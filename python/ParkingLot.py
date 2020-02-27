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
        
        # Create/Search for a database called data
        self.database2 = self.connection['data']
        self.parkingData = self.database2[self.parkingDataCollectionName]
        
    
    # Counts the number of sensors available to the parking lot's collection
    def countSensors(self):
        return len(self.collection.find_one()['sensors'])
    

    def countAvailableSpots(self):
        availableSpots = 0
        listSensors = self.collection.find_one()['sensors']
        
        for sensor in listSensors:
            if sensor['isVacant'] == True:
                availableSpots += 1
        
        return availableSpots
    

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
        info['isVacant'] = self.isVacant(sensor)

        self.collection.update_one(
            { 'lotName': self.lotName },
            { '$push': { 'sensors': info } }
        )
        
        sensor.close()


    # Checks if parking spot is vacant using sensor as param
    def isVacant(self, sensor):
        distance = sensor.distance
        return False if distance < 0.04 else True


    # Loop through each document in the lot's collection and track the changes within the spaces
    def run(self):
        listSensors = self.collection.find_one()['sensors']

        for sensor in listSensors:
            echo = sensor['echo']
            trigger = sensor['trigger']
            sid = sensor['_id']
            
            sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.05, threshold_distance = 0.005)

            vacant = self.isVacant(sensor)

            self.collection.update_one(
                {'lotName': self.lotName, 'sensors._id': sid },
                {'$set' : { 'sensors.$.isVacant' : vacant }}
            )
            
            sensor.close()

        print('Total Parking Spaces in ', self.countAvailableSpots())


    # Drops parking lot's collection within Mongo when stopping the script via keyboard
    def killProgram(self):
        listSensors = self.collection.find_one()['sensors']
        #self.snapshot()
        print('Killing program...')

        for sensor in listSensors:
            self.collection.update_one(
                {'lotName': self.lotName},
                {'$set': {'sensors': []} }
            )
        

    # 'Snapshots' the state of a parking lot and pushes it to a seperate database
    def snapshot(self):
        spots = self.countAvailableSpots()
        dateTime = datetime.now()

        data = {
            'dateTime': dateTime,
            'lotName' : self.lotName,
            'availableSpots': spots
        }

        self.parkingData.insert_one(data)

x = ParkingLot("Raspberry", 40)
