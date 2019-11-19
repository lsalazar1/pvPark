from gpiozero import DistanceSensor
from config import getConnection
from time import sleep 

import pymongo
import dns

class ParkingLot:
    # When initializing an instance of ParkingLot, connect to MongoDB
    def __init__(self, lotName, totalSpots):
        self.lotName = lotName
        self.totalSpots = totalSpots
        self.parkingLot = {}
        self.sensorsList = []

        # Connect to mongodb using connection string
        self.connection = pymongo.MongoClient(getConnection())

        # Create/Search for a database called test
        self.database = self.connection['test']

        # Create/Search for a collection with lot name
        self.collection = self.database[self.lotName]


    def countSensors(self):
        return len(self.sensorsList)

    # Returns the difference of totalSpots in parking lot and available spots
    def countAvailableSpots(self):
        spotsTaken = 0

        for item in self.sensorsList:
            if item["isVacant"] == False:
                spotsTaken += 1
        
        return self.totalSpots - spotsTaken

    # Create a sensor for parking lot with echo and trigger as params
    def createUltrasonic(self, echo, trigger):
        # Each index in sensorsList will have this object per sensor
        info = {
            "_id": "",
            "isVacant": False,
            "echo": echo,
            "trigger": trigger
        }

        sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.02, threshold_distance=0.005)

        # Naming convention is first three chars of lot name and place in sensorsList
        info["_id"] = self.lotName[:3] + str(self.countSensors())

        print("Sensor %s is initializing" % info["sensorID"])

        # Alters info["isVacant"] value based on sensor's reading... use sensor as a param 
        info["isVacant"] = self.isVacant(sensor)

        self.collection.insert_one(info)

    # Checks if parking spot is vacant using sensor as param
    def isVacant(self, sensor):
        # Converts meters to cm        
        distance = sensor.distance * 100

        return False if distance < 2 else True

    # Allows each parking lot instance to create a json file, ready to be shipped to the cloud
    def createDictionary(self):
        self.parkingLot["lotName"] = self.lotName
        self.parkingLot["totalSpots"] = self.totalSpots
        self.parkingLot["netSpotsAfterCars"] = self.countAvailableSpots()
        self.parkingLot["sensors"] = self.sensorsList

        return self.parkingLot

x = ParkingLot("SR Collins", 168)

x.createUltrasonic(echo=23, trigger=24)