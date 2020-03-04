# Purpose: ParkingLot class has all the methods this program will need for the RPi to communicate with MongoDB
# Author: Liam Salazar

from gpiozero import DistanceSensor
from config import getConnection
from datetime import datetime
from time import sleep

import pymongo
import dns

class ParkingLot:
    def __init__(self, lotName, totalSpots):
        '''
        When initializing an instance of ParkingLot,
        connect to MongoDB
        '''
        self.lotName = lotName.replace(' ', '').lower()
        self.parkingDataCollectionName = self.lotName

        self.totalSpots = totalSpots

        # Connect to mongodb using connection string
        self.connection = pymongo.MongoClient(getConnection())

        # Create/Search for a database called test
        self.database = self.connection['test']
        self.collection = self.database[self.lotName]
    
    def countSensors(self):
        '''
        Counts the number of sensors available to
        the parking lot's collection
        '''
        return len(self.collection.find_one()['sensors'])

    def createUS(self, echo, trigger):
        '''
        Create a sensor for parking lot with echo
        and trigger as params.
        '''

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

        self.collection.update_one(
            { 'lotName': self.lotName },
            { '$push': { 'sensors': info } }
        )
        
        sensor.close()

    def run(self):
        '''
        Loop through each document in the lot's collection and
        track the changes within the spaces.
        '''
        availableSpots = 0

        for sensor in self.collection.find_one()['sensors']:
            
            sensorClass = DistanceSensor(echo = sensor['echo'], trigger = sensor['trigger'], max_distance = 0.06, threshold_distance = 0.005)
            sensor["isVacant"] = False if sensorClass.distance < 0.0254 else True

            if sensor["isVacant"] == True:
                availableSpots += 1 

            self.collection.update_one(
                {'lotName': self.lotName, 'sensors._id': sensor['_id'] },
                {'$set' : { 'sensors.$.isVacant' : sensor["isVacant"] }}
            )
            
            sensorClass.close()

        self.collection.update_one(
            {'lotName': self.lotName},
            {'$set': {'availableSpots' : availableSpots}}
        )

        print('Total available spaces in lot is: {}'.format(availableSpots))
        print('{}: {}'.format(self.collection.find_one()["sensors"][0]["_id"], self.collection.find_one()["sensors"][0]["isVacant"]))
        print('{}: {}'.format(self.collection.find_one()["sensors"][1]["_id"], self.collection.find_one()["sensors"][1]["isVacant"]))
        print('{}: {}'.format(self.collection.find_one()["sensors"][2]["_id"], self.collection.find_one()["sensors"][2]["isVacant"]))
        print('{}: {}'.format(self.collection.find_one()["sensors"][3]["_id"], self.collection.find_one()["sensors"][3]["isVacant"]))
        print('{}: {}'.format(self.collection.find_one()["sensors"][4]["_id"], self.collection.find_one()["sensors"][4]["isVacant"]))
        print('{}: {}'.format(self.collection.find_one()["sensors"][5]["_id"], self.collection.find_one()["sensors"][5]["isVacant"]))
        
    def killProgram(self):
        '''
        Drops parking lot's collection within Mongo
        when stopping the script via keyboard.
        '''
        print('Killing program...')

        self.collection.update_one(
            {'lotName': self.lotName},
            {'$set': {'sensors': [], 'availableSpots': 0} }
        )
    
    def test(self):
        senList = self.collection.find_one()["sensors"]
        
        print(senList[0]["isVacant"])           

