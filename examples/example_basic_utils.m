%% QRLab example: basic utility functions
% This example is dependency-light and runs without CVX.

fprintf('Running example_basic_utils...\n');

M = KetBra(3, 1, 2);
assert(isequal(size(M), [3 3]));
assert(M(1,2) == 1);
assert(nnz(M) == 1);

rho = eye(8) / 8;
if exist('PartialTrace', 'file') == 2 && exist('Entropy', 'file') == 2
    value = CQMI(rho, [2 2 2]);
    fprintf('CQMI value for maximally mixed 3-qubit state: %.6f\n', value);
else
    fprintf('Skipping CQMI call because QETLAB functions are not available.\n');
end

fprintf('example_basic_utils completed successfully.\n');
