from ParkingLot import *

if __name__ == '__main__':
   SRC = ParkingLot('SRCollins', 168)

   SRC.createUS(echo=24,trigger=23)
   
   while True:
       SRC.run()
       print('Test')
       sleep(10)
   
   
