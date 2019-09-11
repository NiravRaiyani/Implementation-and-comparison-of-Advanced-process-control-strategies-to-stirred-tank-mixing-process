function  U = ExampleMPC2(x)

global N umax

% initial guess of the future control inputs
Unom = 0.0075*[ones(N,1) ones(N,1)]; 

% The following two vectors define the lower and upper bounds on manipulated input
LB = 0*[ones(N,1) ones(N,1)];
UB = umax*[ones(N,1) ones(N,1)];

options = optimset('LargeScale','off','MaxFunEvals', 10e4,'MaxIter',10e4,'Display','notify');

% 'ExampleMPC_cost' defines the cost function of MPC
% 'ExampleMPC_con' defines the terminal constraint
U = fmincon('ExampleMPC_cost2',Unom,[],[],[],[],LB,UB,'ExampleMPC_con2',options,x);

end

