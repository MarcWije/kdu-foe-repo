#!/usr/bin/python3
import cgi
import cgitb
import RPi.GPIO as GPIO

cgitb.enable()

GPIO.setmode(GPIO.BCM)
GPIO.setup(7, GPIO.OUT)

form = cgi.FieldStorage()
userin = form.getvalue('led')

if (userin == "power_on"):
	GPIO.output(7,1)
else:
	GPIO.output(7,0)
