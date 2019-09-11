function V = ExampleMPC_cost(U,x)
% Calculate the cost along the predicted trajectory for fmincon
% U: a sequence of inputs provided by fmincon
% x: initial state 

global Ad Bd N Q R 

X(:,1)=x; % X will be used to store all the x values along the prediction horizon

% Simulate process for N steps to acquire states using supplied U vector
for k = 1:N
    uk = U(k,1:2)'; 
    X(:,k+1) = Ad*X(:,k) + Bd*uk;
end

% intialize cost/objective function
V=0; 

% Calculate cost 
for i=1:size(X,2)-1
    xk=X(:,i);
    V=V+xk'*Q*xk + (U(i,1:2)')'*R*(U(i,1:2)');
end

%Add the terminal state cost
% V is return to fmincon
xk=X(:,N+1);
V=V+xk'*Q*xk;  %same Q is used here


