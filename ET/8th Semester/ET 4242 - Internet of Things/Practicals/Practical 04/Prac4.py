import paho.mqtt.client as mqtt
import time

mqttBroker = "localhost"
client = mqtt.Client(client_id="publisherclient", callback_api_version=mqtt.CallbackAPIVersion.VERSION2)
client.username_pw_set("marc", "potato")
client.connect(mqttBroker)

while True:
    val = input("Enter LED value (1=on, 0=off, q=quit): ")
    if val.lower() == 'q':
        break
    if val in ['0', '1']:
        client.publish("topic/led", int(val))
        print(f"Just published {val}")
    time.sleep(1)