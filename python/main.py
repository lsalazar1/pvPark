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
    collection = database['SRCollins']

    fakeData = { "_id": "SRC0", "isVacant": True}

    collection.insert_one(fakeData)