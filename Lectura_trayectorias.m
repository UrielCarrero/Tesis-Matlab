
read_all=true;
%option=1->grafica por grado de libertad
%option=2->todos los grados de libertad en una grafica
%option=3->grafica 3D 
option=2;
dataset=input("Please enter dataset folder name:\n","s");

if read_all
    
    Files=dir(strcat('Training\Datasets\',dataset));
    for k=1:length(Files)
       File=Files(k).name;       
       if contains(File,".csv")
           Table = readtable(strcat('Datasets\',dataset,'\',File),'ReadVariableNames',true);
           Variables=Table(:, {'Time','X'	,'Y' ,'Z' ,'Yaw' ,'Roll' ,'Pitch','X_r','Y_r','Z_r','Yaw_r','Pitch_r','Roll_r'});
           Variables=table2array(Variables);
           Plot_Trajectory(Variables, option)
           clc
           disp(File)
           text=input("Press enter for continue or press n+enter for finish the debugging\n","s");
           if text=="n"
               break 
           end
       end 
    end
    
else    
    
    File=input("What file do you want to read?\n",'s')
    Table = readtable(strcat('Training\Datasets\',dataset,'\',File));
    Variables=Table(:, {'Time','X'	,'Y' ,'Z' ,'Yaw' ,'Roll' ,'Pitch','X_r','Y_r','Z_r','Yaw_r','Pitch_r','Roll_r'});
    Variables=table2array(Variables);
    Plot_Trajectory(Variables, option)
    
end



function[]=Plot_Trajectory(Variables, option)

    if option==1

        figure(1)
        %Graficar X con su referencia
        plot(Variables(:,1),[Variables(:,2) Variables(:,8)])
        legend({'X','X_{REF}'},'Location','southwest')
        title('Trayectoria en X')
        xlabel('Tiempo [s]')
        ylabel('Distancia [m]')
        grid on

        figure(2)
        %Graficar Y con su referencia
        plot(Variables(:,1),[Variables(:,3) Variables(:,9)])
        legend({'Y','Y_{REF}'},'Location','southwest')
        title('Trayectoria en Y')
        xlabel('Tiempo [s]')
        ylabel('Distancia [m]')
        grid on

        figure(3)
        %Graficar Z con su referencia
        plot(Variables(:,1),[Variables(:,4) Variables(:,10)])
        legend({'Z','Z_{REF}'},'Location','southwest')
        title('Trayectoria en Z')
        xlabel('Tiempo [s]')
        ylabel('Distancia [m]')
        grid on

        figure(4)
        %Graficar Roll con su referencia
        plot(Variables(:,1),[Variables(:,5) Variables(:,13)])
        legend({'Roll','Roll_{REF}'},'Location','southwest')
        title('Trayectoria en Roll')
        xlabel('Tiempo [s]')
        ylabel('Posicion Angular [rad]')
        grid on


        figure(5)
        %Graficar Pitch con su referencia
        plot(Variables(:,1),[Variables(:,6) Variables(:,12)])
        legend({'Pitch','Pitch_{REF}'},'Location','southwest')
        title('Trayectoria en Pitch')
        xlabel('Tiempo [s]')
        ylabel('Posicion Angular [rad]')
        grid on

        figure(6)
        %Graficar Yaw con su referencia
        plot(Variables(:,1),[Variables(:,7) Variables(:,11)])
        legend({'Yaw','Yaw_{REF}'},'Location','southwest')
        title('Trayectoria en Yaw')
        xlabel('Tiempo [s]')
        ylabel('Posicion Angular [rad]')
        grid on

    elseif option==2

        figure(1)

        %Graficar X con su referencia
        subplot(3,2,1);
        plot(Variables(:,1),[Variables(:,2) Variables(:,8)])
        legend({'X','X_{REF}'},'Location','southwest')
        title('Trayectoria en X')
        xlabel('Tiempo [s]')
        ylabel('Distancia [m]')
        grid on

        %Graficar Y con su referencia
        subplot(3,2,3);
        plot(Variables(:,1),[Variables(:,3) Variables(:,9)])
        legend({'Y','Y_{REF}'},'Location','southwest')
        title('Trayectoria en Y')
        xlabel('Tiempo [s]')
        ylabel('Distancia [m]')
        grid on

        %Graficar Z con su referencia
        subplot(3,2,5);
        plot(Variables(:,1),[Variables(:,4) Variables(:,10)])
        legend({'Z','Z_{REF}'},'Location','southwest')
        title('Trayectoria en Z')
        xlabel('Tiempo [s]')
        ylabel('Distancia [m]')
        grid on

        %Graficar Roll con su referencia
        subplot(3,2,2);
        plot(Variables(:,1),[Variables(:,7) Variables(:,13)])
        legend({'Roll','Roll_{REF}'},'Location','southwest')
        title('Trayectoria en Roll')
        xlabel('Tiempo [s]')
        ylabel('Posicion Angular [rad]')
        grid on

        %Graficar Pitch con su referencia
        subplot(3,2,4);
        plot(Variables(:,1),[Variables(:,6) Variables(:,12)])
        legend({'Pitch','Pitch_{REF}'},'Location','southwest')
        title('Trayectoria en Pitch')
        xlabel('Tiempo [s]')
        ylabel('Posicion Angular [rad]')
        grid on

        %Graficar Yaw con su referencia
        subplot(3,2,6);
        plot(Variables(:,1),[Variables(:,5) Variables(:,11)])
        legend({'Yaw','Yaw_{REF}'},'Location','southwest')
        title('Trayectoria en Yaw')
        xlabel('Tiempo [s]')
        ylabel('Posicion Angular [rad]')
        grid on

    elseif option==3

        figure(4)
        plot3(Variables(:,2),Variables(:,3),Variables(:,4)*(-1),'--','Color','green')
        hold on
        plot3(Variables(:,8),Variables(:,9),Variables(:,10)*(-1),'Color','blue')
        hold on
        plot3(Variables(1,2),Variables(1,3),Variables(1,4)*(-1),'O','Color','red')
        hold on
        plot3(Variables(end,2),Variables(end,3),Variables(end,4)*(-1),'O','Color','black')
        hold off

        legend({'Drone','Reference','Init','End'},'Location','southwest')
        xlabel('X [m]')
        ylabel('Y [m]')
        zlabel('Z [m]')
        title(name)
        grid

    end

end
