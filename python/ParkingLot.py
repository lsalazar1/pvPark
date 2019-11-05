# The gpiozero library allows easier coding of Raspberry Pi components
from gpiozero import DistanceSensor
import json

class ParkingLot:
    sensorsArray = []

    # Initialize the instance with lotName and numSensors set to 0
    def __init__(self, lotName, totalSpots):
        self.lotName = lotName
        self.numSensors = 0
        self.totalSpots = totalSpots
    
    # Returns the number of sensors in sensorsArray
    def countSensors(self):
        return len(self.sensorsArray)

    # Create a sensor obj with the Echo GPIO and Trigger GPIO as params
    def sensor(self, echo, trigger):        
        # Every index in the sensorsArray will have this initial dictionary... Info about each sensor
        sensorInfo = {
            "sensorID": "",
            "isVacant": False,
            "echo": echo,
            "trigger": trigger
        }

         # The naming convetion for each sensor will be the first three chars of the lot name + it's index in the sensorsArray
        sensorInfo["sensorID"] = self.lotName[:3] + str(self.countSensors())

        # Get initial reading of parking space
        if self.isVacant():
            sensorInfo["isVacant"] = True
 
        # Add the sensorInfo object to sensorsArray
        self.sensorsArray.append(sensorInfo)

        # Increment by num of sensors by 1
        self.numSensors += 1
    
    # Read state of parking spot using sensor to see if it's occupied
    def isVacant(self):
        return True
    
    # def updateLotStatus(self):
    #     for item in self.sensorsArray:
    #         # Create sensor 
            
    #         # call isVacant()

    def createJSON(self):
        parkingLot = {}

        parkingLot["lotName"] = self.lotName
        parkingLot["totalSpots"] = self.totalSpots
        parkingLot["sensors"] = self.sensorsArray

        return json.dumps(parkingLot)        


        



# For testing purposes
y = ParkingLot('SRCollins', 168)

y.sensor(18, 23)
y.sensor(5, 6)
print(y.sensorsArray)
#y.updateLotStatus()
x = json.loads(y.createJSON())
print(x)