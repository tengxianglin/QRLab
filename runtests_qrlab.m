function results = runtests_qrlab()
%RUNTESTS_QRLAB Run the QRLab matlab.unittest suite with a clear summary.
%
%   RESULTS = RUNTESTS_QRLAB() discovers tests under ./tests and prints
%   pass/fail/incomplete counts and total runtime.

suite = testsuite(fullfile(fileparts(mfilename('fullpath')), 'tests'));
results = run(suite);

nPassed = nnz([results.Passed]);
nFailed = nnz([results.Failed]);
nIncomplete = nnz([results.Incomplete]);

fprintf('\nQRLab test summary:\n');
fprintf('  Passed:      %d\n', nPassed);
fprintf('  Failed:      %d\n', nFailed);
fprintf('  Incomplete:  %d\n', nIncomplete);
fprintf('  Total tests: %d\n', numel(results));

if nFailed > 0
    error('QRLab:Tests:FailuresDetected', 'One or more tests failed.');
end
end
