import paho.mqtt.client as mqtt
import RPi.GPIO as GPIO
import time


LEDin=18

GPIO.setmode(GPIO.BCM)
GPIO.setup(LEDin,GPIO.OUT)

def  on_message(client, userdata, message):
	if (str(message.payload.decode("utf-8"))== '1'):
		GPIO.output(LEDin,GPIO.HIGH)
		print("Received Message: ", str(message.payload.decode("utf-8")))
		time.sleep(2)
	else:
		GPIO.output(LEDin,GPIO.LOW)
		print("Received Message: ", str(message.payload.decode("utf-8")))
		time.sleep(2)
		
mqttBroker = "192.168.8.115"
client = mqtt.Client(client_id="subscriberclient", callback_api_version=mqtt.CallbackAPIVersion.VERSION2)
client.username_pw_set("marc", "potato")
client.connect(mqttBroker)
client.subscribe("topic/led")
client.on_message = on_message
client.loop_forever()


