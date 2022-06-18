%% Function for Nonlinear measurement 'h(x)'

function h = measure(X_s, S_i, S_k, h_0)

S_i = [S_i, h_0];                                                           % UAV Initial Position
S_k = [S_k, h_0];                                                           % UAV Actual Position

X_k = [X_s; h_0];                                                           % Predicted State

h = norm(X_k - S_i')^2 / norm(X_k - S_k')^2;                                % Non-Linear Measurement calculation
end