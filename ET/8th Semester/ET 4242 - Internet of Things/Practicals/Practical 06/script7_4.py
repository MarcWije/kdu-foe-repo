#!/usr/bin/python3
import cgi
import cgitb
import RPi.GPIO as GPIO

cgitb.enable()

GPIO.setmode(GPIO.BCM)
GPIO.setup(25, GPIO.IN, pull_up_down=GPIO.PUD_UP)

data = GPIO.input(25)
GPIO.cleanup()

print("Content-type: text/html\r\n\r\n")
print("<html><body>")
print("%i" % data)
print("</body></html>")
