import RPi.GPIO as gpio 
import time
gpio.setwarnings(False)
gpio.setmode(gpio.BCM) # Use board pin numbering 
gpio.setup(18, gpio.OUT)

while True: 
	gpio.output(18, True) # led D7 will on
	time.sleep(2)
	gpio.output(18, False) # led off
	time.sleep(2)
