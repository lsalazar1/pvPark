# Purpose: ParkingLot class has all the methods this program will need for the RPi to communicate with MongoDB
# Author: Liam Salazar

from gpiozero import DistanceSensor
from config import getConnection
from time import sleep

import RPi.GPIO as GPIO
import pymongo
import dns

class ParkingLot:
    # When initializing an instance of ParkingLot, connect to MongoDB
    def __init__(self, lotName, totalSpots):
        self.lotName = lotName
        self.totalSpots = totalSpots

        # Connect to mongodb using connection string
        self.connection = pymongo.MongoClient(getConnection())

        # Create/Search for a database called test
        self.database = self.connection['test']

        # Create/Search for a collection with lot name
        self.collection = self.database[self.lotName]
    
    
    # Counts the number of sensors available to the parking lot's collection
    def countSensors(self):
        return self.collection.count()
    
    
    # Returns the difference of totalSpots in parking lot and available spots
    def countAvailableSpots(self):
        spotsTaken = 0
        col = list(self.collection.find())

        for document in col:
            if document["isVacant"] == False:
                spotsTaken += 1
        
        return self.totalSpots - spotsTaken
    
    
    # Create a sensor for parking lot with echo and trigger as params
    def createUS(self, echo, trigger):
        # Each index in sensorsList will have this object per sensor
        info = {
            "_id": "",
            "isVacant": False,
            "sensorType": "US",
            "echo": echo,
            "trigger": trigger
        }

        sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.05, threshold_distance=0.005)

        # Naming convention is first three chars of lot name and place in sensorsList
        info["_id"] = self.lotName[:3] + str(self.countSensors())

        print("Sensor %s is initializing" % info["_id"])

        # Alters info["isVacant"] value based on sensor's reading... use sensor as a param 
        info["isVacant"] = self.isVacant(sensor)

        self.collection.insert_one(info)
        
        sensor.close()
    
    
    # Checks if parking spot is vacant using sensor as param
    def isVacant(self, sensor):
        # Converts meters to cm        
        distance = sensor.distance

        return False if distance < 0.04 else True
    

    # Loop through each document in the lot's collection and track the changes within the spaces
    def run(self):
        col = list(self.collection.find())

        for doc in col:
            echo = doc["echo"]
            trigger = doc["trigger"]

            sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.05, threshold_distance = 0.005)

            vacant = self.isVacant(sensor)
            
            sensor.close()

            self.collection.update_one(
                doc, 
                {'$set' : {'isVacant' : vacant}}
            )
        
        print("Total Parking Spaces in ", self.countAvailableSpots())

    # Drops parking lot's collection within Mongo when stopping the script via keyboard
    def killProgram(self):
        self.collection.drop()
        print('Killing program')

