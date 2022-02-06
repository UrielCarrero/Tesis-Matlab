function[]=simu_test_absQ(simu_time, name, dataset_name)
%name= nombre del archivo a guardar
name=strcat(dataset_name,'\',name)
simOut = sim('mainModels\test_asbQuadcopter', 'ReturnWorkspaceOutputs',simu_time);

%Compara la posicion en X en 110 y al final para saber si la trayectoria es
%estable
% if abs(simOut.X_s.signals.values(end)) > abs(simOut.X_s.signals.values(22000)+(simOut.X_s.signals.values(22000)*0.05))
%    error("Controlador sobre-exigido en Roll") 
% end

%Evaluacion de sobrepaso de limites en X e Y

% if max(abs(simOut.X_s.signals.values)) > 3
%    error("Controlador sobre-exigido en X")
% end
% if max(abs(simOut.Y_s.signals.values)) > 3
%    error("Controlador sobre-exigido en Y")
% end

% if simOut.Roll_s.signals.values(end)>0.4
%     error("Controlador sobre-exigido en Roll")
% elseif simOut.Pitch_s.signals.values(end)>0.4
%     error("Controlador sobre-exigido en Pitch")
% end

% col_header={'Time','X','Y','Z','Yaw','Roll','Pitch', 'Dx','Dy','Dz','P','Q','R','Motor1','Motor2','Motor3','Motor4','X_r', 'Y_r', 'Z_r', 'Yaw_r','Pitch_r','Roll_r', 'Dx_r', 'Dy_r', 'Dz_r', 'P_r', 'Q_r', 'R_r','Flag_Pitch_Roll', 'Ac_Dx' , 'Ac_Dy', 'Ac_Dz', 'Gyro P', 'Gyro Q', 'Gyro R', 'Sonar Altitud' , 'Pressure Altitud', 'Bat_V', 'Bat_Percentage','Acceleracion X','Acceleracion Y','Acceleracion Z','Acceleracion P','Acceleracion Q','Acceleracion R'};
% xlswrite( name, [simOut.X_s.time, simOut.X_s.signals.values, simOut.Y_s.signals.values, simOut.Z_s.signals.values, simOut.Yaw_s.signals.values, simOut.Roll_s.signals.values, simOut.Pitch_s.signals.values, simOut.Dx_s.signals.values, simOut.Dy_s.signals.values, simOut.Dz_s.signals.values, simOut.P_s.signals.values, simOut.Q_s.signals.values, simOut.R_s.signals.values, simOut.TM.signals.values, simOut.pos_r.signals.values, simOut.orient_r.signals.values, simOut.v_pos_r.signals.values, simOut.v_orient_r.signals.values, simOut.FlgRefOrient.signals.values, simOut.Ac_dx.signals.values, simOut.Ac_dy.signals.values, simOut.Ac_dz.signals.values, simOut.Gyro_p.signals.values, simOut.Gyro_q.signals.values, simOut.Gyro_r.signals.values, simOut.Sonar_Altitud.signals.values, simOut.Pressure_Altitud.signals.values, simOut.Bat_V.signals.values, simOut.Bat_Percentage.signals.values, simOut.aceleracion_estimada.signals.values], 'Sheet1' , 'B2' ) ;
% xlswrite( name,col_header,'Sheet1','B1');

header=["Time","X","Y","Z",'Yaw','Roll','Pitch', 'Dx','Dy','Dz','P','Q','R','Motor1','Motor2','Motor3','Motor4','X_r', 'Y_r', 'Z_r', 'Yaw_r','Pitch_r','Roll_r', 'Dx_r', 'Dy_r', 'Dz_r', 'P_r', 'Q_r', 'R_r','Flag_Pitch_Roll', 'Ac_Dx' , 'Ac_Dy', 'Ac_Dz', 'Gyro P', 'Gyro Q', 'Gyro R', 'Sonar Altitud' , 'Pressure Altitud', 'Bat_V', 'Bat_Percentage','Acceleracion X','Acceleracion Y','Acceleracion Z','Acceleracion P','Acceleracion Q','Acceleracion R'];
data=[simOut.X_s.time, simOut.X_s.signals.values, simOut.Y_s.signals.values, simOut.Z_s.signals.values, simOut.Yaw_s.signals.values, simOut.Roll_s.signals.values, simOut.Pitch_s.signals.values, simOut.Dx_s.signals.values, simOut.Dy_s.signals.values, simOut.Dz_s.signals.values, simOut.P_s.signals.values, simOut.Q_s.signals.values, simOut.R_s.signals.values, simOut.TM.signals.values, simOut.pos_r.signals.values, simOut.orient_r.signals.values, simOut.v_pos_r.signals.values, simOut.v_orient_r.signals.values, simOut.FlgRefOrient.signals.values, simOut.Ac_dx.signals.values, simOut.Ac_dy.signals.values, simOut.Ac_dz.signals.values, simOut.Gyro_p.signals.values, simOut.Gyro_q.signals.values, simOut.Gyro_r.signals.values, simOut.Sonar_Altitud.signals.values, simOut.Pressure_Altitud.signals.values, simOut.Bat_V.signals.values, simOut.Bat_Percentage.signals.values, simOut.aceleracion_estimada.signals.values];
cell2csv(name,[header; data]);

figure(1)
plot(simOut.X_s.time,[simOut.X_s.signals.values, simOut.Y_s.signals.values, simOut.Z_s.signals.values])
hold on
plot(simOut.X_s.time, [simOut.pos_r.signals.values])
legend({'X','Y','Z','Ref_X','Ref_Y', 'Ref_Z'},'Location','southwest')
title(name)
hold off
grid on

figure(2)
plot(simOut.X_s.time,[simOut.Yaw_s.signals.values, simOut.Pitch_s.signals.values, simOut.Roll_s.signals.values])
hold on
plot(simOut.X_s.time, [simOut.orient_r.signals.values])
legend({'Yaw','Pitch','Roll','Ref_Yaw','Ref_Pitch', 'Ref_Roll'},'Location','southwest')
title(name)
hold off
grid on


end