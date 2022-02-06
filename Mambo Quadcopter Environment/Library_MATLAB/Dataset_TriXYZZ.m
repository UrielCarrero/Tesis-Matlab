function[]=Dataset_TriXYZZ(save_time, N_Trayectories, Dataset_Name, simu_time, Settling_Times)
%Settling_Times->[Time X Time Y Time Z]

%Flag for generate not step trajectory
assignin('base','Z_Tesp',0)
%Flag for generate Noise trajectory
assignin('base','Noise_Chirp',1)

assignin('base','simu_time',simu_time)
assignin('base','save_time',save_time)

time_stepsZ=zeros(1,26,'double');
time_stepsZ(1)=5;
for i=2:length(time_stepsZ)
    time_stepsZ(i)=time_stepsZ(i-1)+Settling_Times(3);
end
time_stepsX=zeros(1,22,'double');
time_stepsX(1)=5;
for i=2:length(time_stepsX)
    time_stepsX(i)=time_stepsX(i-1)+Settling_Times(1);
end
time_stepsY=zeros(1,22,'double');
time_stepsY(1)=5;
for i=2:length(time_stepsY)
    time_stepsY(i)=time_stepsY(i-1)+Settling_Times(2);
end

clip_posX=min(find(time_stepsX>(simu_time-8)));
clip_posY=min(find(time_stepsY>(simu_time-8)));
clip_posZ=min(find(time_stepsZ>(simu_time-8)));

assignin('base','time_stepsX',time_stepsX)
assignin('base','time_stepsY',time_stepsY)
assignin('base','time_stepsZ',time_stepsZ)

steps_X=zeros(1,22,'double');
steps_Y=zeros(1,10,'double');
steps_Z=zeros(1,26,'double');
steps_Yaw=zeros(1,28,'double');

assignin('base','steps_X',steps_X)
assignin('base','steps_Y',steps_Y)
assignin('base','steps_Z',steps_Z)
assignin('base','steps_Yaw',steps_Yaw)

for trayectoria=1:N_Trayectories 
    
    error_repeat=true;
    
    while(error_repeat==true)
        Z_init=randi([-17 -10], 1)/10;
        Pos_XYZ=[0 0 Z_init];
        signo='neg';

        %Generar triangular Z
        for valor=1:length(steps_Z) 
            Mov=randi([0 50], 1)/100;
            if signo=='neg'
                Mov=-Mov;
            end
            if (Pos_XYZ(3)+Mov) > -1
                signo='neg';
                Mov=-Mov;
            end
            if (Pos_XYZ(3)+Mov) < -2.2
                signo='pos';
                Mov=-Mov;
            end 

            Pos_XYZ(3)=Pos_XYZ(3) + Mov;
            steps_Z(valor)=Mov;
        end

        signo='neg';
        %Generar triangular Y
        for valor=1:length(steps_Y) 
            Mov=randi([0 50], 1)/100;
            if signo=='neg'
                Mov=-Mov;
            end
            if (Pos_XYZ(2)+Mov) > 2
                signo='neg';
                Mov=-Mov;
            end
            if (Pos_XYZ(2)+Mov) < -2
                signo='pos';
                Mov=-Mov;
            end 

            Pos_XYZ(2)=Pos_XYZ(2) + Mov;
            steps_Y(valor)=Mov;
        end

        signo='neg';
        %Generar triangular X
        for valor=1:length(steps_X) 
            Mov=randi([0 50], 1)/100;
            if signo=='neg'
                Mov=-Mov;
            end
            if (Pos_XYZ(1)+Mov) > 2
                signo='neg';
                Mov=-Mov;
            end
            if (Pos_XYZ(1)+Mov) < -2
                signo='pos';
                Mov=-Mov;
            end 

            Pos_XYZ(1)=Pos_XYZ(1) + Mov;
            steps_X(valor)=Mov;
        end
        
        steps_Y(clip_posY:end)=0;
        steps_X(clip_posX:end)=0;
        steps_Z(clip_posZ:end)=0;
        
        assignin('base','Z_init',Z_init)
        assignin('base','steps_X',steps_X)
        assignin('base','steps_Y',steps_Y)
        assignin('base','steps_Z',steps_Z)
        
        time_DisYaw=zeros(1,38,'double');
        P_Pitch=zeros(1,8,'double');
        P_Roll=zeros(1,8,'double');
        P_Yaw=zeros(1,38,'double');
        P_z=zeros(1,20,'double');
        
        Time_Dist=randperm(length(steps_Y),10)
        Dist_Type=randi(4,10,1)
        
        for i=1:length(Time_Dist)
           if Dist_Type(i)==1
               %Roll
               P_Roll(i)=211;
           elseif Dist_Type(i)==2
               %Pitch
               P_Pitch(i)=-211;
           elseif Dist_Type(i)==3
               %Z
               P_z(i)=150;
           elseif Dist_Type(i)==4
               %Yaw
               time_DisYaw(i)=time_stepsZ(Time_Dist(i))+(Settling_Times(3)/2);
               P_Yaw(i)=-211;
               
           end
            
        end
        
        assignin('base','time_DisYaw',time_DisYaw)
        assignin('base','P_z',P_z)
        assignin('base','P_Roll',P_Roll)
        assignin('base','P_Pitch',P_Pitch)
        assignin('base','P_Yaw',P_Yaw)

        name=strcat("Triangular_Esc_ZXYPSO_",int2str(trayectoria),".csv");
        try
            simu_test_absQ(simu_time,name,Dataset_Name)
            error_repeat=false;
        catch
            error_repeat=true;
        end
    
    end
     
end


end