% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
%% Quantum Operation
clear;

% Intialize a quantum density operator

v0 = [1,0];
d_in = v0'*v0;

% Define a depolarizing channel with probability 0.5
Depol = DepolarizingChannel(2, 0.5);

% Apply the channel to the state
d_out = ApplyMap(d_in, Depol);
d_out
