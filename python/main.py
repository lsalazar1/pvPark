from ParkingLot import *

if __name__ == '__main__':
       SRC = ParkingLot('SRCollins', 168)

       # Ultrasonic Sensors    
       SRC.createUS(echo = 24, trigger = 23)    
       SRC.createUS(echo = 22, trigger = 27)
       SRC.createUS(echo = 13, trigger = 6)
       SRC.createUS(echo = 5,trigger = 17)
       SRC.createUS(echo = 16, trigger = 26)
       SRC.createUS(echo = 12, trigger = 25)

       try:
              while True:
                     print('\nChecking for changes in Parking Lot...')
                     SRC.run()
                     sleep(5)
       except KeyboardInterrupt:
              SRC.killProgram()
   
   
