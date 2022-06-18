%% Mean and Covarience 
function [X_m X_cov] = U_transfer(Xi, W, noiseCov)  
%
%
    [n, kmax] = size(Xi);

    X_m = 0;                                           
    for k=1:kmax
      X_m = X_m + W(k)*Xi(:, k);                                             % Mean 
    end

    X_cov = zeros(n, n);
    for k=1:kmax
      X_cov = X_cov + W(k)*(Xi(:, k) - X_m)*(Xi(:, k) - X_m)';               % Covariance 
    end
    X_cov = X_cov + noiseCov;
end