function  U = Optimizer_1(x)

global N umax 

% initial guess of the future control inputs
Unom = 0.0075*[ones(N,1) ones(N,1)]; 

% The following two vectors define the lower and upper bounds on manipulated input
LB = 0*[ones(N,1) ones(N,1)]; % N X 2 matrix
UB = umax*[ones(N,1) ones(N,1)]; % N X 2 matrix

options = optimset('LargeScale','off','MaxFunEvals', 10e4,'MaxIter',10e4,'Display','notify');

% 'MPCcost_1' defines the cost function of MPC
U = fmincon('MPCcost_1',Unom,[],[],[],[],LB,UB,[],options,x);

end

