# Pybullet_Deep_Learning_Drone_Controller

This project facilitates the data extraction, training process and test for neural controllers in Pybullet. Incluiding neural network models, datasets for train neural controllers and files which allows to characterize the PID controller provided by Pybullet based on the response in terms of the control evaluation parameters, create and record a set of several kind of trajectories, create individual trajectories with specified parameters, train neural networks with different architectures and test the performance of the original controller versus the trained neural controllers aaplying different aerodynamic effects. Which hinder the flight performance. 

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

This file allows to evaluates the transitory state response for the controller cf2x provided by Pybullet for an specific axis. Besides measures the step response in terms of settling time, rise time, overshooot, steady state error and control effort by ITSE function. These meaures are printed out in the console at the end of the simultaion. The magnitude of the signal might be specified with the variable **params**, the trajectory type might be specified with the variable **trajectories**, the axis might be defined in the variable **ax** and the duration of the simulation might be defined with the parameter **duration_sec**.

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

###  01_dataset_gen.py

This file allows to simulate and record a set of trajectories automatically by defining some few parameters. For execute this script is necessary to define parameters for the disturbances to perform: the axis where the drone will suffer disturbances might be defined with the variable **DIST_STATES** (it's possible to disturb the same axis showed in the above list, with the same variable values), the magnitude of the disturbances with the list **D_FACTOR**, the probability to suffer a disturbance with the list **D_PROB** and the time where the first disturbance will occur, which might be defined witht the variable **DIST_TIME**. Also it's necessary to define the number of kinds of trajectories to get in the dataset with the variable **N_UNIQUE_TRAJ**, the numer of trajectories per kind of trajectory with the variable **N_SAMPLES**, the name of the folder where the data will be save with the variable **path** and the duration of the simulation with the parameter **duration_sec**. The saved data will be saved in format .csv and you can find the specified folder whitin the folder "files", within "logs".

###  01_dataset_gen_manual.py

This file allows to simulate and save the states of an specified trajectory by manual. For execute this script is necesary to define the parameters for disturbances, the variables **path** and **duration_sec** described previously. It's necessary to define the number of trajectory to save with the variable j, the axes where the trajectories will be performed with the list **axis** and the kind of trajectory per axis with the list **trajectories**, taking in account the position where was located each axis in the list **axis** (the possible values to assign in these both list are the same showed in the description of the file 00_characterize_controller.py)

###  02_replay_trajectory.py

This file allows to plot the states of random trajectories within datasets folders from the path "logs/Datasets/" (in this path you can find the default datasets provided from this repository). For execute this script only is necessary to define the name of the folder which contains the dataset to read, it might be specified with the variable **Dataset_name**. Furthermore if you want to read an specific trajectory you can break the main for loop and assign the name of the file that you want to read to the variable **filename**.

###  03_ANN_vs_Control_lemniscate.py

This file tests the response for lemiscate trajectory along the x and y axis, with a ramp trajectory along z axis, for the original controller provided by Pybullet and the neural controller. For execute this script is necesary to define the parameters for disturbances, the variables **path** and **duration_sec** described above. Also is necessary to define the quantity of previous states to ingress to the neural controller throught the **window** variable, the path and the name of dataset folder with the variables **root** and **dataset** respectibly, the path of the pre-trained neural network model throught the variable **model_path**, the path of the "data_description" file (generated while the traingin, which contains the data analisys from an specific dataset used to normalize the inputs) throught the variable **norm_data_path**, the list of inbount states to the neural network located with in the list **states_list**. Also it'snecessary to  assign a value to **feedback** and **flat** variables according to what's described within the script.

The possible valiues to locate, within the list **states_list** are:
- Position states: 'x', 'y','z','p','q','r'.
- Speed states: 'vx','vy','vz','wp','wq','wr'.
- Aceleration states: 'ax','ay','az','ap','aq',ar','ux','uy','uz','ur'.












