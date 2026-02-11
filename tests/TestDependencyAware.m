classdef TestDependencyAware < matlab.unittest.TestCase
    methods (Test)
        function testCQMISkipsWithoutQETLAB(testCase)
            hasPartialTrace = exist('PartialTrace', 'file') == 2;
            hasEntropy = exist('Entropy', 'file') == 2;
            if ~(hasPartialTrace && hasEntropy)
                testCase.assumeFail('QETLAB dependency not available: skipping CQMI test.');
            end

            rho = eye(8) / 8;
            value = CQMI(rho, [2 2 2]);
            testCase.verifyGreaterThanOrEqual(value, 0);
        end
    end
end
