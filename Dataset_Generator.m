%Variable  Assigment
%Dataset Folder Name
Dataset_Name="DatasetXYZYaw_2022V2_test";
%PID Constant
P_ROLL=0.06656;
I_ROLL=0.001616;
D_ROLL=0.01119;
%The time for start saving the trajectory (in seconds)
save_time_Noise=0;
save_time_Chirp=0;
save_time_OscXYZ=0;
save_time_TriXYZ=0;
save_time_Dist=0;
%The time for stop the simulation (in seconds)
simu_time_Noise=120;
simu_time_OscXYZ=120;
simu_time_TriXYZ=120;
simu_time_Dist=120;
%Quantity of trajectories
QT_Noise=6;
QT_Noise2=6;
QT_Chirp=12;
QT_OscXYZ=36;
QT_TriXYZ=36;
QT_Dist=36;
QT_Dist_PS=36;
%Flag for noise in Roll & Pitch
flag_RollPitch=true;
%The time that the controller will fly with noise
Noise_Time=30;

%Sweep Ranges in Chirp
%Ranges_sweep_time=[Min Sweep_time, Max Sweep_time]
Ranges_sweep_time=[30 60];
%Ranges_Freq=[Min Initial_Freq, Max Initial_Freq, Min Target_Freq,Max Target_Freq]
Ranges_Freq=[0.1 0.3 0.6 1];

%Settling times for trajectories in OscXYZ & TriXYZ
%Settling_times->[Time X Time Y Time Z Time Yaw]
Settling_Times=[20 25 10 16];
%Flag_disturbances->
%[Disturbance_Roll Disturbance_Pitch Disturbance_Yaw Trajectory_Yaw Disturbance_Z Disturbance_Start]
Flag_disturbances=[true true true true true true]

%add path to dataset folder
Dataset_Name=strcat('Datasets\Training\',Dataset_Name);

% Creating folder for saving the dataset
mkdir(Dataset_Name)

% Setting default value for variables
Init_Variables()

% Generate trajectories with noise in Z, Roll and Pitch
Dataset_NoiseZ(save_time_Noise, QT_Noise2, Dataset_Name, simu_time_Noise, flag_RollPitch, Noise_Time)

% Generate trajectories with noise in Z
flag_RollPitch=false;

Dataset_NoiseZ(save_time_Noise, QT_Noise, Dataset_Name, simu_time_Noise, flag_RollPitch, Noise_Time)

Init_Variables()
% Generate chirp trajectories in Z
Dataset_ChirpZ(save_time_Chirp, QT_Chirp, Dataset_Name, Ranges_sweep_time, Ranges_Freq)

Init_Variables()
% Generate oscilation trajectory in XYZ
Dataset_OscXYZZ(save_time_OscXYZ, QT_OscXYZ, Dataset_Name, simu_time_OscXYZ, Settling_Times)

Init_Variables()
% Generate triangle trajectory in XYZ
Dataset_TriXYZZ(save_time_TriXYZ, QT_TriXYZ, Dataset_Name, simu_time_TriXYZ, Settling_Times)

Init_Variables()
% Generate trajectory with disturbances at outburst (Z,Pitch,Roll,Yaw) and trajectories in Yaw
Flag_disturbances(6)=true
Dataset_Dist(save_time_Dist, QT_Dist_PS, Dataset_Name, simu_time_Dist, Flag_disturbances, Settling_Times)

%[Disturbance_Roll Disturbance_Pitch Disturbance_Yaw Trajectory_Yaw Disturbance_Z Disturbance_Start]
Flag_disturbances=[true true true true true false]

Init_Variables()
% Generate trajectory with disturbances (Z,Pitch,Roll,Yaw) and trajectories in Yaw
Dataset_Dist(save_time_Dist, QT_Dist, Dataset_Name, simu_time_Dist, Flag_disturbances, Settling_Times)
