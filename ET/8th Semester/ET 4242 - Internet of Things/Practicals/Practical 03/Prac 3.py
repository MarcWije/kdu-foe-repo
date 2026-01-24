import thingspeak
import time
import adafruit_dht
import board

# Channel Credentials for Thingspeak
channel_id = 3128320
write_key = "LUG820Z9CS59D9VU"

sensor = adafruit_dht.DHT11(board.D4) # for GPIO4

def measure(channel):
    try:
        humidity = sensor.humidity
        temperature = sensor.temperature

        if humidity is not None and temperature is not None:
            print('Temperature = {0:0.1f)°C Humidity = (1:0.1f)%'.format(temperature, humidity))
        else:
            print("Did not receive any reading from sensor. Please check!")
                  
        # update the value
        response = channel.update({'field1': temperature, 'field2': humidity})
    except:
        print("connection failure")

if _name_ == "_main_" :
    channel = thingspeak.Channel(id=channel_id, api_key=write_key)
    while True:
        measure(channel)
        time.sleep(15)
        