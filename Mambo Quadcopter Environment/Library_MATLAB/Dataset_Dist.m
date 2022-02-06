function[]=Dataset_Dist(save_time, N_Trayectories, Dataset_Name, simu_time, Flag_disturbances, Settling_Times)
%Flag_disturbances->
%[Disturbance_Roll Disturbance_Pitch Disturbance_Yaw Trajectory_Yaw Disturbance_Z Disturbance_Start]

%Flag for generate not step trajectory
assignin('base','Z_Tesp',0)
%Flag for generate Noise trajectory
assignin('base','Noise_Chirp',1)

assignin('base','simu_time',simu_time)
assignin('base','save_time',save_time)

steps_Yaw=zeros(1,28,'double');
assignin('base','steps_Yaw',steps_Yaw)

Pos_YawRollPitch=[0 0 0];
signo='neg';

time_stepsZ=zeros(1,26,'double');
time_stepsZ(1)=5;
if Flag_disturbances(6)
    time_stepsZ(1)=15;
end
for i=2:length(time_stepsZ)
    time_stepsZ(i)=time_stepsZ(i-1)+Settling_Times(3);
end

time_stepsY=zeros(1,22,'double');
time_stepsY(1)=5;
if Flag_disturbances(6)
    time_stepsY(1)=15;
end
for i=2:length(time_stepsY)
    time_stepsY(i)=time_stepsY(i-1)+Settling_Times(2);
end

time_stepsX=zeros(1,22,'double');
time_stepsX(1)=5;
if Flag_disturbances(6)
    time_stepsX(1)=15;
end
for i=2:length(time_stepsX)
    time_stepsX(i)=time_stepsX(i-1)+Settling_Times(1);
end

time_stepsYaw=zeros(1,28,'double');
time_stepsYaw(1)=5;
if Flag_disturbances(6)
    time_stepsYaw(1)=15;
end
for i=2:length(time_stepsYaw)
    time_stepsYaw(i)=time_stepsYaw(i-1)+Settling_Times(4);
end

time_DisYaw=zeros(1,38,'double');
time_DisYaw(1)=5;
if Flag_disturbances(6)
    time_DisYaw(1)=15;
end
for i=2:length(time_DisYaw)
    time_DisYaw(i)=time_DisYaw(i-1)+ (2*Settling_Times(4));
end

assignin('base','time_stepsX',time_stepsX)
assignin('base','time_stepsY',time_stepsY)
assignin('base','time_stepsZ',time_stepsZ)
assignin('base','time_stepsYaw',time_stepsYaw)
assignin('base','time_DisYaw',time_DisYaw)

assignin('base','steps_Yaw',zeros(1,28,'double'))
assignin('base','P_Pitch',zeros(1,8,'double'))
assignin('base','P_Roll',zeros(1,8,'double'))
assignin('base','P_Yaw',zeros(1,38,'double'))
assignin('base','P_Z',zeros(1,20,'double'))

for trayectoria=1:N_Trayectories 
    
    error_repeat=true;
    while(error_repeat==true)
        steps_X=zeros(1,22,'double');
        steps_Y=zeros(1,10,'double');
        steps_Y(1)=randi([-50 50], 1)/10;
        steps_X(1)=randi([-50 50], 1)/10;
        
        aux='P_';
        if Flag_disturbances(6)
            %Time for initial perturbation
            PR_Start=randi([15 45], 1,1)/10; 
            aux=strcat(aux,'Start');           
            assignin('base','PR_Start',PR_Start)
        end

        if Flag_disturbances(2)
            %Disturbances in Pitch
            P_Pitch=randi([-211 211], 1,8);
            aux=strcat(aux,'Pitch');
            assignin('base','P_Pitch',P_Pitch)
        end
        
        if Flag_disturbances(1)
            %Disturbances in Roll
            P_Roll=randi([-211 211], 1,8);
            P_Roll(8)=randi([-311 311], 1,1);
            aux=strcat(aux,'Roll');
            assignin('base','P_Roll',P_Roll)
        end
        
        if Flag_disturbances(3)
            %Disturbances in Yaw
            P_Yaw=randi([-211 211], 1,38);
            aux=strcat(aux,'Yaw');
            assignin('base','P_Yaw',P_Yaw)
        end
        
        if Flag_disturbances(5)
            %Disturbances in Z
            P_z=randi([-150 150], 1,20);
            aux=strcat(aux,'Z');
            assignin('base','P_z',P_z)
        end
        
        if Flag_disturbances(4)
            for valor=1:length(steps_Yaw) 
                Mov=randi([0 31416], 1)/10000;
                if signo=='neg'
                    Mov=-Mov;
                end
                if (Pos_YawRollPitch(1)+Mov) > 3.1416
                    signo='neg';
                    Mov=-Mov;
                end
                if (Pos_YawRollPitch(1)+Mov) < -3.1416
                    signo='pos';
                    Mov=-Mov;
                end 

                Pos_YawRollPitch(1)=Pos_YawRollPitch(1) + Mov;
                steps_Yaw(valor)=Mov;
            end
            aux=strcat(aux,'_TYaw');
            assignin('base','steps_Yaw',steps_Yaw)     
        end
        
        name=strcat(aux,'_',int2str(trayectoria),".csv");
        disp(name)
        
        
        
        assignin('base','Z_init',randi([-17 -10], 1)/10)
        assignin('base','steps_Y',steps_Y)
        assignin('base','steps_X',steps_X)
        
        try
            simu_test_absQ(simu_time,name,Dataset_Name)
            error_repeat=false;
        catch
            error_repeat=true;
            disp("Failed")
        end
      
    end
    
end