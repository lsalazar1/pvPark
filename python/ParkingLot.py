# Purpose: ParkingLot class has all the methods this program will need for the RPi to communicate with MongoDB
# Author: Liam Salazar

from gpiozero import DistanceSensor
from config import getConnection
from datetime import datetime
from time import sleep

import pymongo
import dns

class ParkingLot:
    # When initializing an instance of ParkingLot, connect to MongoDB
    def __init__(self, lotName, totalSpots):
        self.lotName = lotName.replace(' ', '').lower()
        self.parkingDataCollectionName = self.lotName

        self.totalSpots = totalSpots

        # Connect to mongodb using connection string
        self.connection = pymongo.MongoClient(getConnection())

        # Create/Search for a database called test
        self.database = self.connection['test']
        self.collection = self.database[self.lotName]
        
    
    # Counts the number of sensors available to the parking lot's collection
    def countSensors(self):
        return len(self.collection.find_one()['sensors'])

    # Create a sensor for parking lot with echo and trigger as params
    def createUS(self, echo, trigger):
        
        # Each index in sensorsList will have this object per sensor
        info = {
            '_id': '',
            'isVacant': False,
            'echo': echo,
            'trigger': trigger
        }

        sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.05, threshold_distance=0.005)

        # Naming convention is first three chars of lot name and place in sensorsList
        info['_id'] = self.lotName[:3] + str(self.countSensors())
        print('Sensor  %s is initializing' % info['_id'])

        # Alters info['isVacant'] value based on sensor's reading... use sensor as a param 
        info['isVacant'] = False if sensor.distance < 0.004 else True

        self.collection.update_one(
            { 'lotName': self.lotName },
            { '$push': { 'sensors': info } }
        )
        
        sensor.close()

    # Loop through each document in the lot's collection and track the changes within the spaces
    def run(self):
        listSensors = self.collection.find_one()['sensors']
        availableSpots = 0

        for sensor in listSensors:
            echo = sensor['echo']
            trigger = sensor['trigger']
            sid = sensor['_id']
            
            sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.05, threshold_distance = 0.005)
            vacant = False if sensor.distance < 0.04 else True

            if vacant == True:
                availableSpots += 1 

            self.collection.update_one(
                {'lotName': self.lotName, 'sensors._id': sid },
                {'$set' : { 'sensors.$.isVacant' : vacant }}
            )
            
            sensor.close()

        self.collection.update_one(
            {'lotName': self.lotName},
            {'$set': {'availableSpots' : availableSpots}}
        )

        print('Total available spaces in lot is: {}'.format(availableSpots))


    # Drops parking lot's collection within Mongo when stopping the script via keyboard
    def killProgram(self):
        #self.snapshot()
        print('Killing program...')

        self.collection.update_one(
            {'lotName': self.lotName},
            {'$set': {'sensors': [], 'availableSpots': 0} }
        )

  
            

