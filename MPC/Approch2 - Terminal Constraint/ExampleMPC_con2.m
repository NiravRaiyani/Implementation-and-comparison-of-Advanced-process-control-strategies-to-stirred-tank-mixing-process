function [g,geq] = ExampleMPC_con2(U,x)
% Calculate the terminal constraint for fmincon
% U: a sequence of inputs provided by fmincon
% x: initial state 

global  N xs

% simulate the system to calculate the terminal state
X(:,1)=x;
for k = 1:N
    uk = U(k,1:2)';
    X(:,k+1) = diff1(X(:,k),uk);
end

% compute the terminal constraint
% the terminal constraint is converted to -0.001 < x(k+N) < 0.001
% this is to avoid potential numerical problems
e = 1e-5;
for i=1:2 % Note that we have two states for this example. Both states should satisfy the constraint
    g(2*i-1) = (X(i,end) - xs(i,1)) - e; 
    g(2*i) = -(X(i,end) - xs(i,1)) - e;
end

g = g'; % g contains all the inequality constraints; g should be a column vector

geq = [];


