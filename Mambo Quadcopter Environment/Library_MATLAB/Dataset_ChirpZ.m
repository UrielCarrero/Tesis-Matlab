function[]=Dataset_ChirpZ(save_time, N_Trayectories, Dataset_Name, Ranges_sweep_time, Ranges_Freq)
%Ranges_sweep_time=[Min Sweep_time, Max Sweep_time]
%Ranges_sweep_time = 30 <-> 60
%Ranges_Freq=[Min Initial_Freq, Max Initial_Freq, Min Target_Freq,Max Target_Freq]
%Initial_Freq = 0.1 <-> 0.3
%Target_Freq = 0.6 <-> 1
assignin('base','save_time',save_time)

%Flag for generate not step trajectory
assignin('base','Z_Tesp',1)
%Flag for choice chirp trajectory
assignin('base','Noise_Chirp',0)

for i=1:N_Trayectories
    error_repeat=true;
    
    while error_repeat
        %Setting time for sweep the frequencies in seconds
        Target_Time=randi([Ranges_sweep_time(1) Ranges_sweep_time(2)], 1);
        assignin('base','simu_time',Target_Time+5)
        simu_time=Target_Time+35;
        assignin('base','Target_Time',Target_Time)
        %Set random initial frequencies in Hz
        Initial_Freq=randi([(Ranges_Freq(1)*10) (Ranges_Freq(2)*10)], 1)/10;
        assignin('base','Initial_Freq',Initial_Freq)
        %Set random target frequencies in Hz
        Target_Freq=randi([(Ranges_Freq(3)*10) (Ranges_Freq(4)*10)], 1)/10;
        assignin('base','Target_Freq',Target_Freq)
        %Height for flight in meters
        assignin('base','Z_init',randi([-17 -10], 1)/10)
    
        try
            simu_test_absQ(simu_time,strcat('ChirpZ_','IF',int2str(Initial_Freq*10),'_TF',int2str(Target_Freq*10),'_',int2str(i),'.csv'),Dataset_Name)
            error_repeat=false;
        catch
            error_repeat=true;
        end
    end
    
end

end