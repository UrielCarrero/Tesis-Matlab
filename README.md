# Pybullet_Deep_Learning_Drone_Controller

This project facilitates the data extraction, training process and test for neural controllers in Pybullet. Incluiding files which allows to characterize 
the PID controller provided by Pybullet based on the response in terms of the control evaluation parameters, create and record a set of several kind of trajectories, 
create individual trajectories with specified parameters, test again the recorded trajectories with different controllers, train neural networks with different 
architectures and test the performance of the original controller versus the trained neural controllers aaplying different aerodynamic effects. Which hinder the 
flight performance. 

## Instalation Guide (Pending):

### Note:
Tensorflow 2.5.0 is incompatible with numpy versions that are above to 1.19.5 version and Pybullet versions that are above to 3.1.7 are incompatible with numpy versions below to 1.20.0 version.

### Recommended Versions:
- python 3.8.10
- tensorflow-gpu 2.5.0
- keras 2.5.0
- pybullet 3.1.6
- numpy 1.19.5
- stable_baselines3 1.5.0
- gym 0.21.0
- cycler 0.11.0
- matplotlib 3.5.1
- pillow 9.0.1


## Applications And File Descriptions (Pending):

In this section we show uses cases and funcionalities of the files within this repository. 

###  00_hello_world.py

This file runs a 50 seconds simulation, with the controller cf2x provided by Pybullet. Where the drone realize a hover and we confirm that the project was installed correctly. When the simulation is finished it should be displayed a graphic with the states of the drone and a three dimension graphic that describes the trajectory, as follows:

<p align = center>
<img src="https://github.com/UrielCarrero/Tesis-Matlab/blob/main/hello_world.png" width="60%" />
</p>

<p align = center>
<img src="https://github.com/UrielCarrero/Tesis-Matlab/blob/main/states_hello_world.png" width="80%" />
</p>

###  00_characterize_controller.py

This file allows to evaluates the transitory state response for the controller cf2x provided by Pybullet for an specific axis. Besides measures the step response in terms of settling time, rise time, overshooot, steady state error and control effort by ITSE function. These meaures are printed out in the console at the end of the simultaion. The magnitude of the signal might be specified with the variable **params**, the trajectory type might be specified with the variable **trajectories**  and the axis might be defined in the variable **ax**.

The axis where it's possible to perform the test are:
- 'x' -> possition in x axis. 
- 'y' -> possition in y axis. 
- 'z' -> possition in z axis.
- 'vx' -> speed in x axis. 
- 'vy' -> speed in y axis.
- 'vz' -> speed in z axis.
- 'r' -> position in yaw axis.
- 'wr' -> speed in yaw axis.

The possible kind of trajectories to test are:

- 'step'
- 'pulse'
- 'ramp'
- 'square'
- 'sin'
- 'cos'
- 'noise'
- 'sawtooth_sweep'
- 'triangular_sweep'
- 'chirp'
- 'chirp_amplin'
- 'big_step_ret0'
- 'big_step_notret0'
- 'step_notret0'
- 'ramp_step_notret0'
- 'step_ret0'
- 'random_step'
- 'stopped'

###  00_characterize_controller.py









