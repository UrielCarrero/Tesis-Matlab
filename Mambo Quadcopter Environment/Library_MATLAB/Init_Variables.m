function[]=Init_Variables()
%% Setting default value for variables
assignin('base','steps_X',zeros(1,22,'double'))
assignin('base','steps_Y',zeros(1,10,'double'))
assignin('base','steps_Z',zeros(1,26,'double'))
assignin('base','steps_Yaw',zeros(1,28,'double'))
assignin('base','time_stepsZ',zeros(1,26,'double'))
assignin('base','time_stepsX',zeros(1,22,'double'))
assignin('base','time_stepsY',zeros(1,22,'double'))
assignin('base','time_stepsYaw',zeros(1,28,'double'))
assignin('base','time_DisYaw',zeros(1,38,'double'))

assignin('base','Net',2)
assignin('base','Z_Tesp',0)
assignin('base','Noise_Chirp',0)
assignin('base','Noise_Amplitude',0.0625)
assignin('base','Noise_Time',1)

%Frequencies in Hz
assignin('base','Initial_Freq',0.3)
assignin('base','Target_Freq',0.9)
%Time for sweep the frequencies in seconds
assignin('base','Target_Time',30)


%Height for flight in meters
assignin('base','Z_init',randi([-17 -10],1)/10)
%Z,Roll,Pitch & Yaw Disturbances
assignin('base','P_z',zeros(1,20,'double'))
assignin('base','P_Roll',zeros(1,8,'double'))
assignin('base','P_Pitch',zeros(1,8,'double'))
assignin('base','P_Yaw',zeros(1,38,'double'))
%Time for perform first disturbance in Roll
assignin('base','PR_Start',145)
%Noise Roll & Pitch
assignin('base','Pitch_Noise',0)
assignin('base','Roll_Noise',0)

end