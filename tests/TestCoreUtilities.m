classdef TestCoreUtilities < matlab.unittest.TestCase
    % Smoke tests for utility and dispatcher functions.

    methods (Test)
        function testKetBraSingleEntry(testCase)
            M = KetBra(4, 2, 3);
            testCase.verifyEqual(size(M), [4 4]);
            testCase.verifyEqual(nnz(M), 1);
            testCase.verifyEqual(M(2, 3), 1);
        end

        function testFlagPoleStateProperties(testCase)
            rho = FlagPoleState(6, 0.25);
            testCase.verifySize(rho, [6 6]);
            testCase.verifyLessThan(norm(rho - rho', 'fro'), 1e-12);
            testCase.verifyLessThan(abs(trace(rho) - 1), 1e-12);

            eigenVals = eig((rho + rho') / 2);
            testCase.verifyGreaterThanOrEqual(min(real(eigenVals)), -1e-12);
        end

        function testComputeEntanglementMeasuresCustomOnly(testCase)
            rho = eye(4) / 4;
            opts = struct();
            opts.dims = [2, 2];
            opts.measures = {'TraceValue'};
            opts.custom_measures = struct('TraceValue', @(state, ~) real(trace(state)));
            opts.normalize_trace = true;

            res = compute_entanglement_measures(rho, opts);
            testCase.verifyTrue(isfield(res, 'TraceValue'));
            testCase.verifyEqual(res.TraceValue.value, 1, 'AbsTol', 1e-12);
        end

        function testLinkProdSkipsWithoutQETLAB(testCase)
            requiredFns = {'PartialTrace', 'PartialTranspose'};
            missing = requiredFns(cellfun(@(fn) exist(fn, 'file') ~= 2, requiredFns));
            if ~isempty(missing)
                testCase.assumeFail(sprintf('QETLAB dependency missing: %s', strjoin(missing, ', ')));
            end

            JA = eye(4);
            JB = eye(4);
            J = LinkProd(JA, JB, [2 2 2 2]);
            testCase.verifySize(J, [4 4]);
        end
    end
end
