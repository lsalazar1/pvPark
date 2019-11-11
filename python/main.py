from config import getConnection
from ParkingLot import *
import pymongo
import dns

if __name__ == '__main__':
    connection = pymongo.MongoClient(getConnection())

    # Connect to DB called test
    database = connection['test']

    # Find a collection called parking
    collection = database['parking']

    # collection.insert_one(testData)