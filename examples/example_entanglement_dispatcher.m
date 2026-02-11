%% QRLab Example: Entanglement Dispatcher with Custom Measure
% This script uses a dependency-light configuration by supplying only
% a custom measure. Built-in CVX/QETLAB measures can be enabled if available.

fprintf('--- example_entanglement_dispatcher ---\n');

rho = eye(4) / 4;
opts = struct();
opts.dims = [2, 2];
opts.measures = {'TraceValue'};
opts.custom_measures = struct('TraceValue', @(state, ~) real(trace(state)));
opts.normalize_trace = true;

res = compute_entanglement_measures(rho, opts);
fprintf('Custom TraceValue measure = %.6f\n', res.TraceValue.value);
