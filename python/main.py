from ParkingLot import *

if __name__ == '__main__':
       SRC = ParkingLot('SRCollins', 168)

       # Ultrasonic Sensors    
       SRC.createUS(echo = 24,trigger = 23)    
       SRC.createUS(echo = 22, trigger = 27)

       try:
              while True:
                     print('\nChecking for changes in Parking Lot...')
                     SRC.run()
                     sleep(15)
       except KeyboardInterrupt:
              SRC.killProgram()
   
   
