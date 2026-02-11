function results = runtests_qrlab()
%RUNTESTS_QRLAB Run QRLab matlab.unittest suites with summary output.

import matlab.unittest.TestSuite

suite = TestSuite.fromFolder(fullfile(fileparts(mfilename('fullpath')), 'tests'));
results = run(suite);

fprintf('\nQRLab test summary:\n');
fprintf('  Total   : %d\n', numel(results));
fprintf('  Passed  : %d\n', nnz([results.Passed]));
fprintf('  Failed  : %d\n', nnz([results.Failed]));
fprintf('  Incomplete (skipped/filtered): %d\n', nnz([results.Incomplete]));

if any([results.Failed])
    error('QRLab:Tests:Failed', 'One or more tests failed.');
end
end
