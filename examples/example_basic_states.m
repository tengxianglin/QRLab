%% QRLab Example: Basic State Utilities
% Demonstrates utility and coherence helper functions that do not require CVX.

fprintf('--- example_basic_states ---\n');

% Build basis operator |2><3| in dimension 4.
M = KetBra(4, 2, 3);
fprintf('Non-zero entries in KetBra result: %d\n', nnz(M));

% Build a flag-pole state and check physical properties.
rho = FlagPoleState(5, 0.6);
fprintf('Trace(flag-pole state) = %.6f\n', trace(rho));
fprintf('Hermitian check (norm(rho-rho'')) = %.3e\n', norm(rho - rho', 'fro'));
