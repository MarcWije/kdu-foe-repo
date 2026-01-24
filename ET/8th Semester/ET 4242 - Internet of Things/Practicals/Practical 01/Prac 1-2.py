# Code for Practice Problem 2

import RPi.GPIO as gpio
import time

gpio.setwarnings(False)
gpio.setmode(gpio.BCM)
gpio.setup(18,gpio.OUT)
gpio.setup(14,gpio.OUT)
gpio.setup(15,gpio.OUT)

while True:
	gpio.output(18,True)
	time.sleep(2)
	gpio.output(18,False)
	time.sleep(1)
	gpio.output(18,True)
	gpio.output(14,True)
	time.sleep(1)
	gpio.output(18,False)
	gpio.output(14,False)
	time.sleep(1)
	gpio.output(15,True)
	time.sleep(2)
	gpio.output(15,False)
	time.sleep(2)


