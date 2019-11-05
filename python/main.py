from config import getConnection
import pymongo
import dns

if __name__ == '__main__':
    connection = pymongo.MongoClient(getConnection())

    # Specify name of database
    database = connection['test']

    # Specify name of collection
    collection = database['parking']

    # Fake data we're sending to MongoDB -> Also JSON
    testData = {
        "parkingLot": "S.R. Collins",
        "Sensors": [
            {
                "sensorID": "001",
                "isVacant": False
            },
            {
                "sensorID": "002",
                "isVacant": True
            }
        ]
    }

    collection.insert_one(testData)