classdef TestUtils < matlab.unittest.TestCase
    methods (Test)
        function testKetBraShapeAndEntry(testCase)
            M = KetBra(4, 2, 3);
            testCase.verifySize(M, [4 4]);
            testCase.verifyEqual(M(2,3), 1);
            testCase.verifyEqual(nnz(M), 1);
        end

        function testKetBraIndexValidation(testCase)
            testCase.verifyError(@() KetBra(3, 4, 1), 'QRLab:KetBra:IndexOutOfRange');
        end

        function testComputeEntanglementMeasuresCustom(testCase)
            rho = eye(4) / 4;
            opts = struct();
            opts.dims = [2 2];
            opts.measures = {'TraceValue'};
            opts.custom_measures.TraceValue = @(x,~) real(trace(x));

            out = compute_entanglement_measures(rho, opts);
            testCase.verifyEqual(out.TraceValue.value, 1, 'AbsTol', 1e-12);
        end

        function testComputeEntanglementMeasuresTable(testCase)
            rho = eye(4) / 4;
            opts = struct();
            opts.dims = [2 2];
            opts.measures = {'TraceValue'};
            opts.custom_measures.TraceValue = @(x,~) real(trace(x));
            opts.return_table = true;

            out = compute_entanglement_measures(rho, opts);
            testCase.verifyClass(out, 'table');
            testCase.verifyEqual(out.Value(1), 1, 'AbsTol', 1e-12);
        end
    end
end
