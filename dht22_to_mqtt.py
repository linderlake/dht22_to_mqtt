#!/usr/bin/env python3
import Adafruit_DHT
import time
import paho.mqtt.client as mqtt
import logging
import os

MQTT_HOST = os.getenv('MQTT_HOST', 'rbpi')
MQTT_PORT = int(os.getenv('MQTT_PORT', 1883))
DHT22_SENSOR_PIN = int(os.getenv('DHT22_SENSOR_PIN', 4))

logging.basicConfig(level=logging.INFO)

def read_and_publish(client):
    try:
        humidity, temperature = Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, DHT22_SENSOR_PIN)
        if humidity is not None and temperature is not None:
            client.publish("sensor/temperature",str(temperature))
            client.publish("sensor/humidity",str(humidity))
    except Exception as e:
        logging.error(f"Failed to read from DHT sensor: {e}")

def main():
    client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
    try:
        client.connect(MQTT_HOST, MQTT_PORT, 60)
    except Exception as e:
        logging.error(f"Failed to connect to MQTT server: {e}")
        return

    client.loop_start()

    while True:
        read_and_publish(client)
        time.sleep(20)

if __name__ == "__main__":
    main()