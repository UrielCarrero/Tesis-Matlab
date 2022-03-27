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

This file runs a 50 seconds simulation, with the controller cf2x provided by Pybullet. Where the drone realize a hover and we confirm that the project was installed correctly.
When the simulation is finished it should be displayed a graphic with the states of the drone and a three dimension graphic that describes the trajectory:

![hello_world](https://user-images.githubusercontent.com/47391487/160295674-3a539e30-f032-4c03-ac0b-d7ead45c1ac3.png)

![states_hello_world](https://user-images.githubusercontent.com/47391487/160295855-6d542660-ade7-4de5-9f58-d2e57e540c95.png)




