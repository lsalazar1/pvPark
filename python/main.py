from ParkingLot import *

if __name__ == '__main__':
   SRC = ParkingLot('SRCollins', 168)

   SRC.createUS(echo=24,trigger=23)
   
   while True:
       print('Checking for changes in Parking Lot')
       SRC.run()
       sleep(10)
   
   
