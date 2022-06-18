%% Function for Sigma points and Weights.

function [X_P W_P] = Sigma(x, P, kappa)

n    = size(x(:),1);
nPts = 2*n+1;  

alpha =0.000001;                                                            % Tunable parameter
beta =2;                                                                    % Tunable parameter

lambda = alpha^2*(n+kappa)-n;                                               % Scaling Parameter

W_P=zeros(1,nPts);                                                          % Initilizing allocation
X_P=zeros(n,nPts);                                                          % Initilizing allocation

square_P_m=sqrt(n+lambda)*chol(P)';                                           % Square root of weighted covarience

X_P=[x x+square_P_m x-square_P_m];                            % Sigma points matrix
 

W_P=[lambda 0.5*ones(1,nPts-1) 0]/(n+lambda);                               % Weights for each sigma point matrix

W_P(nPts+1) = W_P(1) + (1-alpha^2) + beta;                                  % Weight for zero covarience

end
