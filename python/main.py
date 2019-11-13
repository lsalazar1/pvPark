from ParkingLot import *
from config import getConnection

import pymongo
import dns

if __name__ == '__main__':
    # Establish a connection to the MongoDB cluster using getConnection()
    connection = pymongo.MongoClient(getConnection())

    # Find the database called 'test'...
    database = connection['test']

    # Find a collection within the test db called 'parking'
    collection = database['parking']

    # Create an object
    SR_Collins = ParkingLot('SRCOllins', 168)

    # Create a sensor
    SR_Collins.createUltrasonic(echo = 24, trigger = 23)

    print(SR_Collins.createDictionary())
    
    # Post dictionary to db
    collection.insert_one(SR_Collins.createDictionary())

    print('Hello')