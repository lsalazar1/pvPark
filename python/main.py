from config import getConnection
from ParkingLot import *
import pymongo
import dns

if __name__ == '__main__':
    # Establish a connection using string connector in default.ini
    connection = pymongo.MongoClient(getConnection())

    # Find the database called 'test'...
    database = connection['test']

    # Within the 'test' database, find a collection called 'parking'...
    collection = database['parking']