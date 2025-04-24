Odometry Pipeline on STM32F303 Discovery

This project implements a complete odometry pipeline from scratch using an STM32F303 Discovery board and various software tools. You won’t find any plug-and-play GitHub repos—everything here is custom-built.

Hardware

Board: STM32F303 Discovery (STM32F303VCT6)

IMU Sensors:

Gyroscope: ST L3GD20 (or pin-compatible I3G4250D)

Accelerometer & Magnetometer: ST LSM303DLHC (3‑axis accel + 3‑axis mag)

Repository Contents

File/Folder

Description

AudrinoFile.zip

Arduino IDE sketch (.ino) for the STM32F303 Discovery. Reads raw accel, gyro & mag data via I²C/SPI, performs basic sensor fusion and outputs binary frames over serial.

imu_trajectory.csv

Template CSV for logged data. Columns: timestamp,accel_x,accel_y,accel_z,gyro_x,gyro_y,gyro_z,mag_x,mag_y,mag_z,pos_x,pos_y

plot_trajectory.py

Python script to parse imu_trajectory.csv and plot 2D odometry using matplotlib.

simulation.m

MATLAB script to simulate sensor fusion & odometry model, tune parameters, and compare against logged data.

odometry_model.slx

Simulink model: reads binary serial frames, integrates acceleration to position, and streams results back over serial. IDE‑agnostic—works with Arduino IDE, STM32CubeIDE, etc. Note: ensure raw accel/gyro/mag data is encoded in binary for Simulink compatibility.

Getting Started

1. Flash the STM32 Code

Unzip AudrinoFile.zip

Open the .ino sketch in Arduino IDE (or import into STM32CubeIDE)

Select STM32F303 Discovery as the target board

Upload the sketch

The board will begin streaming IMU data (binary frames) over the USB serial port.

2. Log Data to CSV

Use a serial terminal (e.g., PuTTY, minicom) or a custom logger to capture the binary frames

Convert each frame into comma-separated values matching the template

Save as imu_trajectory.csv

3. Plot with Python

pip install matplotlib pandas
python plot_trajectory.py imu_trajectory.csv

This will display a 2D trajectory plot of your robot’s path.

4. Run MATLAB Simulation

Open simulation.m in MATLAB

Adjust sensor noise / fusion parameters as needed

Run the script to generate simulated vs. recorded odometry plots

5. Use Simulink Model

Open odometry_model.slx in Simulink

Configure the serial port block to match your USB port and baud rate

Ensure incoming data is in binary (packed accel/gyro/mag) format

Run the model to integrate acceleration into position and visualize in real‑time

Extending the Project

Swap in different IMU modules by updating I²C/SPI initialization and data decoding

Improve sensor fusion with a Kalman or complementary filter

Export trajectories to GIS formats for mapping

Integrate with ROS or other middleware for full robot autonomy

License

MIT License. Feel free to use, modify, and extend as you like!

