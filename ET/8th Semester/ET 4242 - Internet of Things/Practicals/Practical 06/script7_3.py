#!/usr/bin/python3
import cgi, cgitb
import RPi.GPIO as GPIO

cgitb.enable()

GPIO.setmode(GPIO.BCM)
GPIO.setup(7, GPIO.OUT)

form = cgi.FieldStorage()
userin = form.getvalue('led')

print("Content-type: text/html\r\n\r\n")
print("<html><body>")
if (userin == "power_on" ):
	print("<h1>LED: Power On!<br></h1>")
	GPIO.output(7, GPIO.HIGH)
else:
	print("<h1>LED: Power Off!<br></h1>")
	GPIO.output(7, GPIO.LOW)

print ("</body></html>")
