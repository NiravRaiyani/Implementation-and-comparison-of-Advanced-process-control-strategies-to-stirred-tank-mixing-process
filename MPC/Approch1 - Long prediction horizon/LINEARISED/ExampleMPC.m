function  U = ExampleMPC(x)

global N umax 

% initial guess of the future control inputs
Unom = umax*[ones(N,1) ones(N,1)]; 

% The following two vectors define the lower and upper bounds on manipulated input
LB = -umax*[ones(N,1) ones(N,1)];
UB = umax*[ones(N,1) ones(N,1)];

options = optimset('LargeScale','off','MaxFunEvals', 10e4,'MaxIter',10e4,'Display','notify');

% 'ExampleMPC_cost' defines the cost function of MPC
U = fmincon('ExampleMPC_cost',Unom,[],[],[],[],LB,UB,[],options,x);

end

