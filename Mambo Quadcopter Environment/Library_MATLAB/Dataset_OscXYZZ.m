function[]=Dataset_OscXYZZ(save_time, N_Trayectories, Dataset_Name, simu_time, Settling_times)
%Settling_times->[Time X Time Y Time Z]

%Flag for generate not step trajectory
assignin('base','Z_Tesp',0)
%Flag for generate Noise trajectory
assignin('base','Noise_Chirp',1)

assignin('base','simu_time',simu_time)
assignin('base','save_time',save_time)

time_stepsZ=zeros(1,26,'double');
time_stepsZ(1)=5;
for i=2:length(time_stepsZ)
    time_stepsZ(i)=time_stepsZ(i-1)+Settling_times(3);
end
time_stepsX=zeros(1,22,'double');
time_stepsX(1)=5;
for i=2:length(time_stepsX)
    time_stepsX(i)=time_stepsX(i-1)+Settling_times(1);
end
time_stepsY=zeros(1,22,'double');
time_stepsY(1)=5;
for i=2:length(time_stepsY)
    time_stepsY(i)=time_stepsY(i-1)+Settling_times(2);
end

Pos_XYZ=[0 0];

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

%Programacion Oscilacion cuadrada
%Vector para guardar las trayectorias ya realizadas
Trayectories_osc=zeros(N_Trayectories,1);
%Bandera de verificacion de trayectorias repetidas
flag="repeat";
 

for actual_trayect=1:N_Trayectories
    Z_init=randi([-17 -10], 1)/10;
    error_repeat=true;
    flag_posval=true;
    while(error_repeat)
        while flag=="repeat"
            %Genera la amplitud maxima (entre 0.25 y 0.05)
            A_max=(rand(1,1,'double')*(0.25-0.05))+0.05;

            if isempty(find(Trayectories_osc(actual_trayect,:)==A_max))
                Trayectories_osc(actual_trayect,:)=A_max;
                flag='no';
            else
                flag="repeat";
            end
        end
        flag="repeat";
        steps_Z(1)=-A_max;
        steps_Z(2)=2*A_max;
        val_ant=A_max*0.85;
        for i=3:2:10
            steps_Z(i)=-(val_ant*2)-(val_ant*0.15);
            steps_Z(i+1)=val_ant*2;
            val_ant=val_ant*0.85;
        end
        steps_Z(10)=steps_Z(10)/2;
        steps_Z(11:20)=fliplr(steps_Z(1:10));
        steps_Z(21:22)=(rand(1,2,'double')*(0.25-0.05))+0.05;
        %Genera trayectorias X e Y
        Mov_XYZ=[0 0 0];
        flag_posval=false
        for i=1:length(steps_X)
            while(flag_posval~=true)
                Mov_XYZ=[randi([-50 50], 1)/100  randi([-50 50], 1)/100];
                if (Pos_XYZ(1) + Mov_XYZ(1)) < 2 && (Pos_XYZ(1) + Mov_XYZ(1)) > -2
                    if (Pos_XYZ(2) + Mov_XYZ(2)) < 2 && (Pos_XYZ(2) + Mov_XYZ(2)) > -2
                        flag_posval=true;
                        Pos_XYZ=Pos_XYZ+Mov_XYZ;
                    end
                end
            end
            flag_posval=false;
            steps_X(i)=Mov_XYZ(1);

            if i<10 
                steps_Y(i)=Mov_XYZ(2);
            end
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
               time_DisYaw(i)=time_stepsZ(Time_Dist(i))+(Settling_times(3)/2);
               P_Yaw(i)=-211;
               
           end
            
        end
        
        assignin('base','time_DisYaw',time_DisYaw)
        assignin('base','P_z',P_z)
        assignin('base','P_Roll',P_Roll)
        assignin('base','P_Pitch',P_Pitch)
        assignin('base','P_Yaw',P_Yaw)
        
        name=strcat("Oscilacion_Esc_ZXYPSO_",int2str(actual_trayect),".csv");
        try
            simu_test_absQ(simu_time,name,Dataset_Name)
            error_repeat=false;
        catch
            error_repeat=true;
        end
    end
end


end