function V = MPCcost_1(U,x)
% Calculate the cost along the predicted trajectory for fmincon
% U: a sequence of inputs provided by fmincon
% x: initial state 

global  N Q R xs us

X(:,1)=x ; % X will be used to store all the x values along the prediction horizon

% Simulate process for N steps to acquire states using supplied U vector
for k = 1:N
    uk = U(k,1:2)';
    X(:,k+1) = diff1(X(:,k),uk);
end

% intialize cost/objective function
V=0; 

% Calculate cost 
for i=1:size(X,2)-1
    xk=X(:,i);
    V= V+(xk-xs)'*Q*(xk-xs) + (U(i,1:2)'- us)'*R*(U(i,1:2)'-us);
end

%Add the terminal state cost
% V is return to fmincon
xk=X(:,N+1);
V=V+(xk-xs)'*Q*(xk-xs);  %same Q is used here


