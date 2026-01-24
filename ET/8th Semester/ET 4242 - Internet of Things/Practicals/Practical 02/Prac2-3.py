import RPi.GPIO as gpio 
import time
leds = [18,19,20,21,22,23,24,25]
gpio.setwarnings(False)
gpio.setmode(gpio.BCM) # Use board pin numbering 

for pin in leds:
	gpio.setup(pin, gpio.OUT)
	gpio.output(pin, False)
	
while True: 
	for pin in leds:
		gpio.output(pin, True)
		time.sleep(1)
		gpio.output(pin, False)
