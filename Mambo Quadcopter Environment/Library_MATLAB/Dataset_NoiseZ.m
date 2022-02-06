function[]=Dataset_NoiseZ(save_time, N_Trayectories, Dataset_Name, simu_time, flag_RollPitch, Noise_Time)

assignin('base','simu_time',simu_time)
assignin('base','save_time',save_time)
%Flag for generate not step trajectory
assignin('base','Z_Tesp',1)
%Flag for generate Noise trajectory
assignin('base','Noise_Chirp',1)
%Assignin simulation time 
assignin('base','simu_time',simu_time)
Pitch_Noise=0;
Roll_Noise=0;
aux="NoiseZ_";
if flag_RollPitch
    Pitch_Noise=1;
    Roll_Noise=1;
    assignin('base','Pitch_Noise',Pitch_Noise)
    assignin('base','Roll_Noise',Roll_Noise)
    strcat(aux,"RollPitch_")
end

for i=1:N_Trayectories
    error_repeat=true;
    while(error_repeat)
        
        steps_X=zeros(1,22,'double');
        steps_Y=zeros(1,10,'double');
        steps_Y(1)=randi([-50 50], 1)/10;
        steps_X(1)=randi([-50 50], 1)/10;
        assignin('base','steps_Y',steps_Y)
        assignin('base','steps_X',steps_X)
        
        aux="Noise_Z";
        
        if flag_RollPitch
            aux=strcat(aux,"PitchRoll_");
        else
            aux=strcat(aux,"_");
        end
        
        %The time that the controller will fly with noise
        assignin('base','Noise_Time',(Noise_Time*2))
        %Setting Noise Amplitude (random number between 0.0625 - 0.0156
        %0.0625->0.2m
        assignin('base','Noise_Amplitude',randi([156 625], 1)/10000)

        %Height for flight in meters
        assignin('base','Z_init',randi([-17 -10], 1)/10)

        try
            simu_test_absQ(simu_time,strcat(aux,int2str(i),'.csv'),Dataset_Name)
            error_repeat=false;
        catch
            error_repeat=true;
        end
        
    end    
end

end