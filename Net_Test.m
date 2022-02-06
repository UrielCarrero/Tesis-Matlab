%% Inicialization

%Bandera para valor incial del buffer 
%Estado inicial -> initial_state=1;
%Ceros -> initial_state=0;
initial_state=1;

% feedback
feedback=false;

simu_time=10;

%Ingresar a la red 3 estados anteriores mas el actual
delays=31;

%PID Constant
P_ROLL=0.06656;
I_ROLL=0.001616;
D_ROLL=0.01119;

Init_Variables()

Net=2;
%modelpath='Training\Models\Models XYZ\Not LSTM\Controlador_XYZ_FC_A1.h5'
modelpath='Training\Models\Models Z\DummyLSTM_1_4W.h5';
dataset_summary='data_description_DatasetXYZYaw_2022V2_0.csv';

% Choose Network

if Net==0
    
    % Leer red feedback XYZ
    net=importKerasNetwork(modelpath)
    % analyzeNetwork(net)
    save('Training\Models\net.mat','net')

elseif Net==1
  
    % Leer red feedback XYZ
    net=importKerasNetwork(modelpath)
    % analyzeNetwork(net)
    save('Training\Models\net.mat','net')
    
elseif Net==2
    
    myprediction()
    
end

%% States Normalization

% find(strcmp([sts_array], 'Acceleracion P'))

%Archivo de donde tomar el estado inicial
file='Training/Datasets/DatasetZ_2/Oscilacion_Escalonata_Z_22';

%Descipcion de los datos para normalizacion 
data_Info = readtable(dataset_summary);

%Arreglo de todos los estados que se guardan en los archivos .csv
sts_array={'X','Y','Z','Yaw','Roll','Pitch','Dx','Dy','Dz','P','Q','R','X_r','Y_r','Z_r','Yaw_r','Pitch_r','Roll_r','Dx_r','Dy_r','Dz_r','P_r','Q_r','R_r','Flag_Pitch_Roll','Ac_Dx','Ac_Dy','Ac_Dz','GyroP','GyroQ','GyroR','SonarAltitud','PressureAltitud','Bat_V','Bat_Percentage','AcceleracionX','AcceleracionY','AcceleracionZ','AcceleracionP','AcceleracionQ','AcceleracionR'};

labels={'Motor1','Motor2','Motor3','Motor4'};

for i=1:4
    norm_act((i*2)-1)=table2array(data_Info(4,{strcat('Motor',int2str(i))}));
    norm_act(i*2)=table2array(data_Info(8,{strcat('Motor',int2str(i))}));
end
%data_Info=removevars(data_Info,{'Norm_type'})
sts_data_Info=data_Info;
sts_data_Info(:,labels) = [];
disp("Estados de Entrada:")
sts_cnames=sts_data_Info.Properties.VariableNames
normalization_sts=zeros(length(sts_cnames),3);

for i=1:length(sts_cnames)
    %Maximo
    disp(sts_cnames(i))
    normalization_sts(i,1)=table2array(data_Info(8,sts_cnames(i)));
    %Minimo
    normalization_sts(i,2)=table2array(data_Info(4,sts_cnames(i)));
    %Posicion en el array de estados general
    normalization_sts(i,3)=find(strcmp(sts_array, sts_cnames(i)));
end

if initial_state==1
    x0=zeros(length(sts_cnames),1);
    %Definir el vector de estado inicial extrayendo el estado inicial de un
    %archivo random
    T = readtable(file);

    %Intest=T(1, {'X'	,'Y'	,'Z' ,'Yaw'	,'Roll'	,'Pitch'	,'Dx'	,'Dy'	,'Dz'	,'P'	,'Q'	,'R'	,'X_r'	,'Y_r'	,'Z_r'	,'Yaw_r'	,'Pitch_r',	'Roll_r'	,'Dx_r'	,'Dy_r',	'Dz_r',	'AcceleracionX',	'AcceleracionY'	,'AcceleracionZ'	});
    Intest=T(1,sts_cnames);
    
    for i=1:length(sts_cnames)
        if table2array(data_Info(8,sts_cnames(i)))==table2array(data_Info(4,sts_cnames(i)))
            x0(i)=table2array(Intest(:,sts_cnames(i)));
        else
            x0(i)=(table2array(Intest(:,sts_cnames(i)))-table2array(data_Info(4,sts_cnames(i))))/(table2array(data_Info(8,sts_cnames(i)))-table2array(data_Info(4,sts_cnames(i))));
        end
    end   

else
    x0=zeros(length(sts_cnames),1); 
end

if feedback
    x0_f=cat(1,x0,zeros(3*4,1));
end

save_time=0; 

%% Definicion de Trayectoria de Prueba

Z_init=randi([-17 -10], 1)/10;

% Step inicial para prueba de seguimiento y tiempo de estabilizacion

% steps_Z(1)=randi([-50 50], 1)/100;
% steps_Y(1)=randi([-50 50], 1)/100;
% steps_X(1)=randi([-50 50], 1)/100;
% steps_Yaw(1)=randi([-31416 31416], 1)/10000;
% Z_init=-1.2;
% steps_Z(1)=0.5;
%steps_Y(1)=0.5;
%steps_X(1)=0.5;
% steps_Yaw(1)=1.1416;

simout=sim('Mambo Quadcopter Enviroment\mainModels\test_asbQuadcopter', 'ReturnWorkspaceOutputs',simu_time);
