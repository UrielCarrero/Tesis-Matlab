% %clc
% %clear all
% modelfile = 'Modelos/ControlLSTM_XYZYaw_1.h5';
% global net2
% net2 = importKerasNetwork(modelfile)
% 
% analyzeNetwork(net2)
% save('Modelos\netLSTM1.mat','net2')
% 
% %https://es.mathworks.com/help/deeplearning/ref/seriesnetwork.predict.html#mw_21c0b4b7-8b3d-4d72-903c-f956074aff7c
% %c-by-s matrices, where c is the number of features of the sequences and s
% %is the sequence length.
%% Seleccion del archivo


path='Training\Datasets\Dataset_PSO_2022V1\';
file='Oscilacion_Esc_ZXYPSO_4_test.csv';
data = readtable(strcat(path,file));

delays=99;

dataset_summary='data_description_DatasetXYZYaw_2022V2_0.csv';

%Bandera para valor incial del buffer 
%Estado inicial -> initial_state=1;
%Ceros -> initial_state=0;
initial_state=1;
feedback=false;

%% States Normalization

% find(strcmp([sts_array], 'Acceleracion P'))

%Archivo de donde tomar el estado inicial
file='Training/Datasets/Dataset_PSO_2022V1/Oscilacion_Esc_ZXYPSO_9.csv';

%Descipcion de los datos para normalizacion 
data_Info = readtable(dataset_summary);

%Arreglo de todos los estados que se guardan en los archivos .csv
sts_array={'X','Y','Z','Yaw','Roll','Pitch','Dx','Dy','Dz','P','Q','R','X_r','Y_r','Z_r','Yaw_r','Pitch_r','Roll_r','Dx_r','Dy_r','Dz_r','P_r','Q_r','R_r','Flag_Pitch_Roll','Ac_Dx','Ac_Dy','Ac_Dz','GyroP','GyroQ','GyroR','SonarAltitud','PressureAltitud','Bat_V','Bat_Percentage','AcceleracionX','AcceleracionY','AcceleracionZ','AcceleracionP','AcceleracionQ','AcceleracionR'};

labels={'Motor1','Motor2','Motor3','Motor4'};

for i=1:4
    norm_act((i*2)-1)=table2array(data_Info(4,{strcat('Motor',int2str(i))}));
    norm_act(i*2)=table2array(data_Info(8,{strcat('Motor',int2str(i))}));
end

sts_data_Info=data_Info;
sts_data_Info(:,labels) = [];
disp("Estados de Entrada:")
sts_cnames=sts_data_Info.Properties.VariableNames
normalization_sts=zeros(length(sts_cnames),3);

for i=1:length(sts_cnames)
    %Maximo
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

%% Creacion de los datos de entrada

Test.time = data{:,{'Time'}};
data=removevars(data,{'Time'});
Test.signals.values = table2array(removevars(data,{'Motor1','Motor2','Motor3','Motor4'}));
test_size=size(removevars(data,{'Motor1','Motor2','Motor3','Motor4'}))
Test.signals.dimensions = test_size(2);

%% Test Simulink data
modelfile = 'Training\Models\LSTM XYZ_Yaw\DatasetXYZYaw_2022V2_0_100.h5';
net = importKerasNetwork(modelfile)
prediction=zeros([(2001) 4]);

for i=1:length(out.Input_test.time)
    prediction(i,:)=predict(net,out.Input_test.signals.values(:,:,i));
end
figure(1)
plot(out.Input_test.time, prediction)
