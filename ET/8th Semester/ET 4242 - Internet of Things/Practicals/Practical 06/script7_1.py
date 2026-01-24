import RPi.GPIO as GPIO

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

GPIO.setup(7, GPIO.OUT)
GPIO.setup(25, GPIO.IN,pull_up_down=GPIO.PUD_UP)

while True:
    data = GPIO.input(25)
    GPIO.output(7,data)

