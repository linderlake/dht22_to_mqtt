# Adafruit MQTT Sensor Publisher

This project reads data from a DHT22 sensor and publishes it to an MQTT server.

## Requirements

- Python 3
- Adafruit_DHT Python library
- paho-mqtt Python library

## Installation

1. Clone this repository.
2. Install the required Python libraries using pip:

    ```bash
    pip install -r requirements.txt
    ```

## Usage

Run the script with Python:

```bash
python dht22_to_mqtt.py
```

By default, the script will try to connect to an MQTT server running on localhost and read data from a DHT sensor connected to pin 4 every 20th second.
You can configure these settings by setting the following environment variables:

- MQTT_HOST: The hostname of the MQTT server.
- MQTT_PORT: The port number of the MQTT server.
- DHT22_SENSOR_PIN: The GPIO pin number that the DHT22 sensor is connected to.

## Setting up as a Service

You can set up the script to run as a service on a Linux system using the provided bash script `install_as_a_service.sh`. This script will create a systemd service that starts the Python script at boot.

Run the bash script with sudo and provide the necessary arguments:

```bash
sudo ./install_as_a_service.sh mqtt_sensor_publisher /path/to/your/script/dht22_to_mqtt.py your_mqtt_host your_mqtt_port your_sensor_pin
```

Replace `mqtt_sensor_publisher`, `/path/to/your/script/dht22_to_mqtt.py`, `your_mqtt_host`, `your_mqtt_port`, and `your_sensor_pin` with your actual settings. E.g.:
```bash
sudo ./install_as_a_service.sh mqtt_sensor_publisher /home/linderlake/dht22_to_mqtt.py 192.168.1.10 1883 4
```

The script will create a systemd service and an environment file with your settings. The service will start automatically at boot. You can check the status of the service with:

```bash
sudo systemctl status mqtt_sensor_publisher.service
```