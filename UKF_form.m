%% Defining the function for Unscented Kalman Filter.
function [x_state,P_cov,K_EKF_gain,innovation,zp]=UKF_form(x_init,x_current,h_0,alpha,x_state_ini,P_cov_ini,F_KF,G_KF,Q_KF,R_KF)

%% Global declaration of variables
global n
global m
global kappa
global X_s P_s

%% Initilization of estimate and error covarience.    
X_s = x_state_ini;                                                          % Initial State
P_s = P_cov_ini;                                                            % Initial Covariance matrix    

%% Constants
n = 2;
m = 1;
kappa = 0;
    
%% Extracting the sigma points.
[Xi, W] = Sigma(X_s, P_s, kappa);                                           % Xi is the sigma point
                                                                            % W is the weight of the sigma point

%% Tranformation of sigma point to non-linear function. 

fXi = zeros(n, 2*n+1);                                                      % Initializing new vectors for non linear function

for k = 1:2*n+1
    fXi(:, k) = Xi(:,k);
end

%% Unscented transformation for the Estimated quantity.
[xp Pp] = U_transfer(fXi, W, Q_KF);

%% Adding sigma points to measurement.

hXi = zeros(m, 2*n+1);                                                      % Initializing new vector for measurement 

for k = 1:2*n+1
    
    hXi(:, k) = measure(fXi(:,k),x_init,x_current,h_0);
end

    
%% Unscented transformation for the Estimated quantity.
[zp Pz] = U_transfer(hXi, W, R_KF);

%% Cross Co-relation Matrix between state space and predicted space
Pxz = zeros(n, m);
for k = 1:2*n+1
    Pxz = Pxz + W(k)*(fXi(:,k) - xp)*(hXi(:,k) - zp)';
end

%% Kalman gain calculation
K_EKF_gain = Pxz*(inv(Pz));

%% %% Update Step for State Estimate and Error Covarience. 
innovation = alpha - zp;
X_s = xp + K_EKF_gain*(alpha - zp);                                         % Updated State Estimate
x_state = X_s;

P_s = Pp - K_EKF_gain*Pz*K_EKF_gain';                                       % Updated Error Covarience
P_cov = P_s;
end





