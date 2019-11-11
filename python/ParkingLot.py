from gpiozero import DistanceSensor
from time import sleep 
import json

class ParkingLot:
    # Basically a constructor
    def __init__(self, lotName, totalSpots):
        self.lotName = lotName
        self.totalSpots = totalSpots
        self.parkingLot = {}
        self.sensorsList = []

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
    def createSensor(self, echo, trigger):
        # Each index in sensorsList will have this object per sensor
        info = {
            "sensorID": "",
            "isVacant": False,
            "echo": echo,
            "trigger": trigger
        }

        sensor = DistanceSensor(echo = echo, trigger = trigger, max_distance = 0.02, threshold_distance=0.005)

        # Naming convention is first three chars of lot name and place in sensorsList
        info["sensorID"] = self.lotName[:3] + str(self.countSensors())

        print("Sensor %s is initializing" % info["sensorID"])

        # Alters info["isVacant"] value based on sensor's reading... use sensor as a param 
        info["isVacant"] = self.isVacant(sensor)

        self.sensorsList.append(info)

    # Checks if parking spot is vacant using sensor as param
    def isVacant(self, sensor):
        # Converts meters to cm        
        distance = sensor.distance * 100

        if distance < 2:
            return False
        
        return True

    def createJSON(self):
        self.parkingLot["lotName"] = self.lotName
        self.parkingLot["totalSpots"] = self.totalSpots
        self.parkingLot["netSpotsAfterCars"] = self.countAvailableSpots()
        self.parkingLot["sensors"] = self.sensorsList

        return json.dumps(self.parkingLot)
        



# # For testing purposes
# y = ParkingLot('SRCollins', 168)

# y.sensor(18, 23)
# y.sensor(5, 6)
# print(y.sensorsArray)
# #y.updateLotStatus()
# x = json.loads(y.createJSON())
# print(x)