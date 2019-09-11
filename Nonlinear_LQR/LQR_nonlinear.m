clc;
clear all;
A=[-0.0075 0; 0 -0.015];
B=[1 1; -22.33 44.66];
C=[1 0; 0 1];
D= [0 0; 0 0];
Q=[1 0;0 0.0025];
R=[1 0; 0 1];
[K,P,e]=lqr(A,B,Q,R);
eig(Q)
eig(R)
disp('P=')
disp(P)
%Verifying the results obtained by LQR
%K=(R^-1)*B' * P
%A_1=A-B*K
%B=[0 0;0 0]
%%Controlability check
Co = ctrb(A,B);
unco = length(A) - rank(Co);
if unco == 0
    disp('System is Controllable')
else disp('System is Not-Controllable')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%LQR

%Initial Condition
%State Variables:
V(1)    = 0.8;   
rho(1)  =840;
%Input Variables:
F1(1)   =0;
F2(1)   =0;
t(1)    =0;
%Steady-state Condition
F1S = 0.01;
F2S = 0.005;
VS  = 1.0;
rhoS= 845.333;

%Time Parameters
ts      =0.1; 
tf      =5;


for i=1:1:(tf/ts)
    V(i+1)  = V(i) + (-0.015*sqrt(V(i)) + F1(i) + F2(i))*ts;
    rho(i+1)= rho(i) + ((1/V(i))*((823-rho(i))*F1(i)+(890-rho(i))*F2(i)))*ts;
    F1(i+1) = F1S -(0.8313*(V(i+1)-VS) - 0.0272*(rho(i+1)-rhoS));
    F2(i+1) = F2S -(0.5458*(V(i+1)-VS) + 0.0416*(rho(i+1)-rhoS));
    t(i+1)  = t(i) + ts;
end
figure(1)

    subplot(2,2,1)
        plot(t,V,'LineWidth',2)
        title(['Response of the system with initial condition V(0) = ' num2str(V(1)) ' to steady state'] )
        xlabel('time')
        ylabel('Volume')
    subplot(2,2,2)
        plot(t,rho,'LineWidth',2)
        title(['Response of the system with initial condition \rho(0) = ' num2str(rho(1)) ' to steady state'] )
        xlabel('time')
        ylabel('Density')
    subplot(2,2,3)
        plot(t,F1,'LineWidth',2)
        xlabel('time')
        ylabel('Flow Inlet-1')
    subplot(2,2,4)
        plot(t,F2,'LineWidth',2)
        xlabel('time')
        ylabel('Flow Inlet-2')

%Disturbance
%Initial Condition
%State Variables:
V(1)    =1;   
rho(1)  =845.333;
%Input Variables:
F1(1)   =0;
F2(1)   =0;
t(1)    =0;
%Disturbance
for i=1:1:(tf/ts)
    if i == 3
        dV(i)=0.2;
        drho(i)=25;
    else dV(i)=0; drho(i)=0;
    end
end
ts      =0.1; 
tf      =5;


for i=1:1:(tf/ts)
    V(i+1)  = V(i) + dV(i) + (-0.015*sqrt(V(i)) + F1(i) + F2(i))*ts;
    rho(i+1)= rho(i) + drho(i) + ((1/V(i))*((823-rho(i))*F1(i)+(890-rho(i))*F2(i)))*ts;
     F1(i+1) = F1S -(0.8313*(V(i+1)-VS) - 0.0272*(rho(i+1)-rhoS));
    F2(i+1) = F2S -(0.5458*(V(i+1)-VS) + 0.0416*(rho(i+1)-rhoS));
    t(i+1)  = t(i) + ts;
end
figure(2)
title('Response of the system with initial condition V{0}=0.1 and rho{0}=0.1')
    subplot(2,2,1)
        plot(t,V,'LineWidth',2)
        title(['Impulse Response of the system with impulse of V(0.3) = ' num2str(dV(3)) ' to steady state']) 
        xlabel('time')
        ylabel('Volume')
    subplot(2,2,2)
        plot(t,rho,'LineWidth',2)
        title(['Impulse Response of the system with impulse of \rho(0.3) = ' num2str(drho(3)) ' to steady state'])
        xlabel('time')
        ylabel('Density')
    subplot(2,2,3)
        plot(t,F1,'LineWidth',2)
        xlabel('time')
        ylabel('Flow Inlet-1')
    subplot(2,2,4)
        plot(t,F2,'LineWidth',2)
        xlabel('time')
        ylabel('Flow Inlet-2')
figure(3)
plot(dV,'LineWidth',2)
title(['Volume impulse of V = ' num2str(dV(3)) ' given to the system'])
 xlabel('time')
 ylabel('Volume')
figure(4)
plot(drho,'LineWidth',2)
title(['Density impulse of V = ' num2str(drho(3)) ' given to the system'])
xlabel('time')
ylabel('Density')












