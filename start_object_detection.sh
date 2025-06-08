#!/bin/bash

# Raspberry Pi Object Detection Startup Script

# Add logging
LOG_FILE="/home/pi/object_detection_startup.log"
echo "$(date): Starting object detection script" >> $LOG_FILE

# Wait for the system to fully boot
sleep 10

# Change to the home directory
cd /home/pi

# Activate the TensorFlow Lite virtual environment
echo "$(date): Activating TensorFlow Lite environment" >> $LOG_FILE
source tflite/bin/activate

# Check if activation was successful
if [ $? -ne 0 ]; then
    echo "$(date): Failed to activate virtual environment" >> $LOG_FILE
    exit 1
fi

# Navigate to the object detection directory
echo "$(date): Changing to object detection directory" >> $LOG_FILE
cd examples/lite/examples/object_detection/raspberry_pi/

# Check if directory exists
if [ ! -d "$(pwd)" ]; then
    echo "$(date): Object detection directory not found: $(pwd)" >> $LOG_FILE
    exit 1
fi

# Check if the model file exists
if [ ! -f "cat.tflite" ]; then
    echo "$(date): Model file not found: cat.tflite" >> $LOG_FILE
    exit 1
fi

# Run the object detection script
echo "$(date): Starting object detection" >> $LOG_FILE
python detect.py --model cat.tflite

# Log the exit status
echo "$(date): Object detection script exited with status: $?" >> $LOG_FILE
