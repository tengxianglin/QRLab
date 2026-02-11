%% QRLab example: configurable measure dispatch
% This example demonstrates custom measures without requiring CVX-based built-ins.

fprintf('Running example_measure_dispatch...\n');

rho = eye(4) / 4;
opts = struct();
opts.dims = [2 2];
opts.measures = {'TraceValue', 'FroNorm'};
opts.custom_measures.TraceValue = @(x,~) real(trace(x));
opts.custom_measures.FroNorm = @(x,~) norm(x, 'fro');

result = compute_entanglement_measures(rho, opts);
disp(result);

fprintf('example_measure_dispatch completed successfully.\n');
