# Code for Practice Problem 1

import RPi.GPIO as gpio
import time
gpio.setwarnings(False)
gpio.setmode(gpio.BCM)
gpio.setup(18,gpio.OUT)

gpio.output(18,True)
time.sleep(2)
gpio.output(18,False)



