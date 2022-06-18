clc
clear all;
close all;
% Load Mat file
load result.mat

% Plot the true and predicted jammer state 'x' and 'y'
figure
yline(x_t_vec(1),'r--');
hold on
plot(x_state(1,:),'r');
yline(x_t_vec(2),'b--');
plot(x_state(2,:),'b');
xlim([50 1800])
legend('x True position','x Estimate position','y True position','y Estimate position')
xlabel('Time step')
ylabel('Jammer position [m]')
title('True and Predicted Jammer State x and y')

% Kalman gain
figure 
plot(K_UKF_gain(1,:),'r')
hold on
plot(K_UKF_gain(2,:),'b')
xlim([50 1800])
legend('Kalman gain for measurement','Kalman gain for current state estimate')
xlabel('Time step')
ylabel('Kalman Gain')
title('Kalman gain for UKF')

% Plot of True and Estimate Measurement 
figure
plot(P_r_filt_ratio(:,1),'r');
hold on
plot(h(1,:),'b--');
xlim([50 1800])
legend('True Measurement','Estimate Measurement')
xlabel('Time step')
ylabel('Measurement')
title('True and Predicted Measurement')

% plot Uncorrelated and Correlated Covarience Calculation
for i = 1:1800
    sig_x_UKF(i) = P_cov(1,1,i);
    sig_y_UKF(i) = P_cov(2,2,i);
end

for i = 1:1800
    sig_xy_UKF(i) = P_cov(1,2,i);
    sig_yx_UKF(i) = P_cov(2,1,i);
end
% Uncorrelated and Uncorrelated Covarience 
figure
plot(sig_x_UKF)
hold on
plot(sig_y_UKF)
xlim ([200 1800])
xlabel('Time step')
ylabel('P')
legend('σ^{2}_x','σ^{2}_y')
title ('Uncorrelated Covarience matrix for UKF')

figure
plot(sig_xy_UKF)
hold on
plot(sig_yx_UKF)
xlim ([200 1800])
xlabel('Time step')
ylabel('P')
legend('σ_{xy}','σ_{yx}')
title ('Correlated Covarience matrix for UKF')



%Plot Innovation
figure
plot(Innovation(1,:))
xlim([50 1800])
legend('UKF Innovation')
xlabel('Time step')
ylabel('Innovation')
title('Innovation for Unscented Kalman Filter')