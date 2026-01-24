#!/usr/bin/python3

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(7, GPIO.OUT)
GPIO.setup(25, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# 1Hz square wave with 50% duty cycle

data = GPIO.input(25)

while ( data == 0 ):
	data = GPIO.input(25)
	
togglevalue = 1
while ( data == 1 ):
	GPIO.output(7, togglevalue)
	togglevalue = not togglevalue
	time.sleep(0.02)
	data = GPIO.input(25)
	
GPIO.cleanup()
