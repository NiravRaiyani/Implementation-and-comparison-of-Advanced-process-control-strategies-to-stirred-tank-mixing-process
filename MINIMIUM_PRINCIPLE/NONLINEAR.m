%% Example of a Two-Point Boundary Value Problem (TBBVP)
% ODEs (2 state equations, 2 co-state equations)
%
% dot x1 = x2
% dot x2 = -x1 + x2-p2
% dot p1 = -2x1 + p2
% dot p2 = -x2 - p1
%
% Boundary conditions:
% 
% x1(0) = 0, x2(0) = 0
% p1(2) = 1, p2(2) = 1
%
% We can use 'bvp4c' to solve for the TPBVP
clc
clear all;
close all;
s=0.0005;
%% Solve the problem
% defines discretization points and provides initial guesses
solinit = bvpinit([0:0.1:8], [1;855.333;s;s] ,[]); 

% solves the boundary value problem
% function 'xpode' defines the ODEs
% function 'xpbc' defines the boundary conditions
% 'solinit' provides the discretization points and initial guesses
sol = bvp4c(@xpode, @xpbc, solinit);
[r l]= size(sol.x)
for i= 1:1: l
u1(i) =  (1/2)*(0.02 - sol.y(3,i) - (sol.y(4,i)/sqrt(sol.y(1,i)))*(823 - sol.y(2,i)));
u2(i) =  (1/2)*(0.02 - sol.y(3,i) - (sol.y(4,i)/sqrt(sol.y(1,i)))*(890 - sol.y(2,i)));
end
%% Plot the trajectories of x1, x2, p1, p2
% sol.x stores the discretization points (t)
% sol.y stores trajectories 
figure(1)
    
    subplot(2,2,1)
        plot(sol.x,sol.y(1,:),'r','LineWidth',2)
        ylabel('VOLUME(V*)')
        xlabel('t')
        title('Initial Condition V(0) = 0.8 m^3 to steady state')
    subplot(2,2,2)
        plot(sol.x,sol.y(2,:),'b','LineWidth',2)
        ylabel('density(\rho*)')
        xlabel('t')
        title('Initial Condition \rho(0) = 840 Kg/m^3 to steady state')
    subplot(2,2,3)
        plot(sol.x,u1,'k','LineWidth',2)
        ylabel('F_1*')
        xlabel('t')
    subplot(2,2,4)
        plot(sol.x,u2,'k','LineWidth',2)
        ylabel('F_2*')
        xlabel('t')    
    
figure(2)

    subplot(1,2,1)
        plot(sol.x,sol.y(3,:),'LineWidth',2)
        ylabel('p_1')
        xlabel('t')
        title('Trajectory of P_1')
    subplot(1,2,2)
        plot(sol.x,sol.y(4,:),'r','LineWidth',2)
        ylabel('p_2')
        xlabel('t')
        title('Trajectory of P_2')
        %('Trajectories of p_1_1, p_1_2, p_2_2')
%% define the ODEs
function dxdt = xpode(t,x)
% x = [x1 x2 p1 p2]^T
dxdt = [0.02 - x(3) - (856.5*(x(4)/sqrt(x(1)))) +  ((x(2)*x(4))/sqrt(x(1))) - 0.015*sqrt(x(1));
        (1/sqrt(x(1)))*(((823-x(2))*(0.01 - (x(3)/2)-((x(4)/sqrt(x(1)))*(411.5 - (0.5*x(2)))))) + ((890-x(2))*(0.01-(0.5*x(3))-(x(4)/sqrt(x(1)))*(445-(0.5*x(2))))));
        -(2*x(1)-2-(0.00075*x(3))/sqrt(x(1))-((x(4)/(2*(x(1)^(3/2))))*((823-x(2))*(0.01 - (x(3)/2)-(x(4)/sqrt(x(1)))*(411.5-(x(2)/2))) -(890-x(2))*(0.01 - (x(3)/2)-(x(4)/sqrt(x(1)))*(445 - (x(2)/2))))));
        -(-4.2265+ (0.005*x(2))-(x(4)/sqrt(x(1)))*(0.02-x(3)-(856.5*x(4)/sqrt(x(1)))+(x(4)*x(2)/sqrt(x(1)))))];             
end

%% define the boundary conditions
function res = xpbc(ya,yb)
% ya defines the boundary condition at t0 = 0
% yb defines the boundary condition at tf = 2
res = [ya(1)-0.8;       % x1(0) = 0
       ya(2)-840;       % x2(0) = 0
       yb(3);   % p1(2) = 1
       yb(4)];  % p2(2) = 1 

end



 

