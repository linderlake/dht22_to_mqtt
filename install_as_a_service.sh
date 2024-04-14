#!/bin/bash

# Variables
SERVICE_NAME=$1
SCRIPT_PATH=$2
USER_NAME=${SUDO_USER:-$(whoami)}
MQTT_HOST=$3
MQTT_PORT=$4
DHT22_SENSOR_PIN=$5

# Check if all arguments are provided
if [ $# -ne 5 ]; then
    echo "Usage: $0 <service_name> <script_path> <mqtt_host> <mqtt_port> <dht22_sensor_pin>"
    echo "(Example: sudo ./install_as_a_service.sh mqtt_sensor_publisher /home/linderlake/dht22_to_mqtt.py 192.168.1.10 1883 4)"
    exit 1
fi

# Create the service file
echo "[Unit]
Description=$SERVICE_NAME
After=network.target

[Service]
ExecStart=$SCRIPT_PATH
Restart=always
User=$USER_NAME
EnvironmentFile=/etc/default/$SERVICE_NAME

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/$SERVICE_NAME.service

# Create environment file
echo "MQTT_HOST='$MQTT_HOST'
MQTT_PORT='$MQTT_PORT'
DHT22_SENSOR_PIN='$DHT22_SENSOR_PIN'" | sudo tee /etc/default/$SERVICE_NAME

# Reload the systemd daemon
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable $SERVICE_NAME.service

# Start the service
sudo systemctl start $SERVICE_NAME.service

# Print the status of the service
sudo systemctl status $SERVICE_NAME.service
