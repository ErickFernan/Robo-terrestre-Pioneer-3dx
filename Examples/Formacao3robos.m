%%Controle forma??o 2 rob?s;

clear all
close all
clc
V = VREP;
V.vConnect;
%% Declarando a figura
figure(1)
hold on
axis([-5,5,-5,5])
%% Carregando os objetos do cen?rio

V.vHandle('Pioneer_p3dx');
V.vHandle('Pioneer_p3dx','0');
V.vHandle('Pioneer_p3dx','1');

%% Declarando o trace

[Pos.Xc1,Pos.X1, Pos.U1] = V.vGetSensorData(1);
[Pos.Xc2,Pos.X2, Pos.U2] = V.vGetSensorData(2);
[Pos.Xc3,Pos.X3, Pos.U3] = V.vGetSensorData(3);
Pos.Xd1 = zeros(8,1);
Pos.Xd2 = zeros(8,1);
Pos.Xd3 = zeros(8,1);

%% Inicializando vari?veis para o controle

it=0;
tmax=90;
t=tic;ta=tic;
Dados = [0 0 0 0 0 0 0 0];
k1 = 0.8;
k2 = 0.8;
T = 90; w = 2*pi/T;

%% Plotar Rastro

while toc(t)<tmax
    if toc(ta)>0.1
        
        ta=tic;
        it=it+1;
        
        %% Controle
        
        Xf    = 3*cos(w*toc(t));
%         Xf    = 3*sin(0.5*w*toc(t));
        dXf   = -3*w*sin(w*toc(t));
%         dXf   = 1.5*w*cos(0.5*w*toc(t));
        
        Yf    = 3*sin(w*toc(t));
%         Yf    = 3*sin(w*toc(t));
        dYf   = 3*w*cos(w*toc(t));
%         dYf   = 3*w*cos(w*toc(t));
       
        Psif  = atan2((Yf-Dados(end,2)),(Xf-Dados(end,1)));
        dPsif = (1/(Xf^2 +Yf^2))*(dYf*Xf-Yf*dXf);
        
        Lf    = .7;
        dLf   = 0;

        Pos.Xd1(1) = Xf + Lf*cos(Psif);
        Pos.Xd1(2) = Yf + Lf*sin(Psif);
        Pos.Xd1(7) = dXf - Lf*sin(Psif)*dPsif - cos(Psif)*dLf;
        Pos.Xd1(8) = dYf + Lf*cos(Psif)*dPsif - sin(Psif)*dLf;
        
        Pos.Xd2(1) = Xf - Lf*cos(Psif+pi/2);
        Pos.Xd2(2) = Yf - Lf*sin(Psif+pi/2);
        Pos.Xd2(7) = dXf + Lf*sin(Psif+pi/2)*dPsif + cos(Psif+pi/2)*dLf;
        Pos.Xd2(8) = dYf - Lf*cos(Psif+pi/2)*dPsif + sin(Psif+pi/2)*dLf;
        
        Pos.Xd3(1) = Xf + Lf*cos(Psif+pi/2);
        Pos.Xd3(2) = Yf + Lf*sin(Psif+pi/2);
        Pos.Xd3(7) = dXf - Lf*sin(Psif+pi/2)*dPsif - cos(Psif+pi/2)*dLf;
        Pos.Xd3(8) = dYf + Lf*cos(Psif+pi/2)*dPsif - sin(Psif+pi/2)*dLf;
        
        
        %% Robot 1
        
        [Pos.Xc1, Pos.X1, Pos.U1] = V.vGetSensorData(1);
        Pos.theta1= atan2(Pos.X1(2)-Pos.Xc1(2),Pos.X1(1)-Pos.Xc1(1));
        K1=[cos(Pos.theta1) -0.15*sin(Pos.theta1); sin(Pos.theta1) 0.15*cos(Pos.theta1)];
        Pos.Xtil1 = Pos.Xd1([1 2])-Pos.X1;
        Pos.Ud1=K1\(Pos.Xd1([7 8])+k1*tanh(k2*Pos.Xtil1([1 2])));
        V.vSendControlSignals(Pos.Ud1,1);
        
        %% Robot 2
        
        [Pos.Xc2, Pos.X2, Pos.U2] = V.vGetSensorData(2);
        Pos.theta2= atan2(Pos.X2(2)-Pos.Xc2(2),Pos.X2(1)-Pos.Xc2(1));
        K2=[cos(Pos.theta2) -0.15*sin(Pos.theta2); sin(Pos.theta2) 0.15*cos(Pos.theta2)];
        Pos.Xtil2 = Pos.Xd2([1 2])-Pos.X2;
        Pos.Ud2=K2\(Pos.Xd2([7 8])+k1*tanh(k2*Pos.Xtil2([1 2])));
        V.vSendControlSignals(Pos.Ud2,2);
        
        %% Robot 3
        
        [Pos.Xc3, Pos.X3, Pos.U3] = V.vGetSensorData(3);
        Pos.theta3= atan2(Pos.X3(2)-Pos.Xc3(2),Pos.X3(1)-Pos.Xc3(1));
        K3=[cos(Pos.theta3) -0.15*sin(Pos.theta3); sin(Pos.theta3) 0.15*cos(Pos.theta3)];
        Pos.Xtil3 = Pos.Xd3([1 2])-Pos.X3;
        Pos.Ud3=K3\(Pos.Xd3([7 8])+k1*tanh(k2*Pos.Xtil3([1 2])));
        V.vSendControlSignals(Pos.Ud3,3);
        
        %%Plotar o rastro
        
        Dados = [Dados; [Xf Yf Pos.Xd1(1) Pos.Xd1(2) Pos.Xd2(1) Pos.Xd2(2) Pos.Xd3(1) Pos.Xd3(2)]];
        try
            delete(h);
        end
        h(1) = plot(Dados(:,[1]),Dados(:,[2]),'b');
        h(2) = plot(Dados(:,[3]),Dados(:,[4]),'--k');
        h(3) = plot(Dados(:,[5]),Dados(:,[6]),'.k');
        h(4) = plot(Dados(:,[7]),Dados(:,[8]),'.-k');
        drawnow;
    end
end


%% Comando STOP Robots

Ud = [0; 0];
V.vSendControlSignals(Ud,1);
V.vSendControlSignals(Ud,2);
V.vSendControlSignals(Ud,3);


%% Desconecta Matlab e V-REP

V.vDisconnect;
