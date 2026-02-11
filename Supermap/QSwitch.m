function [JoutPlus, JoutMinus] = QSwitch(JN, d)
%QSWITCH Compute post-selected quantum-switch Choi matrices.
%   [JOUTPLUS, JOUTMINUS] = QSWITCH(JN, D) builds the quantum switch using
%   two copies of channel N (with Choi matrix JN), and returns output Choi
%   matrices conditioned on control measurements in |+> and |->.
%
%   Syntax
%   ------
%   [JoutPlus, JoutMinus] = QSwitch(JN, d)
%
%   Inputs
%   ------
%   JN : square numeric matrix
%       Choi matrix of the inserted channel.
%   d : positive integer scalar
%       Input/output dimension of the inserted channel.
%
%   Outputs
%   -------
%   JoutPlus : numeric matrix
%       Output Choi matrix for control measurement outcome |+>.
%   JoutMinus : numeric matrix
%       Output Choi matrix for control measurement outcome |->.
%
%   Notes
%   -----
%   Requires QETLAB functions MaxEntangled, Tensor, PermuteSystems,
%   PartialTranspose, and PartialTrace.

arguments
    JN (:,:) {mustBeNumeric}
    d (1,1) {mustBeInteger, mustBePositive}
end

if size(JN, 1) ~= size(JN, 2)
    error('QRLab:QSwitch:NonSquareChoi', 'JN must be a square matrix.');
end
if size(JN, 1) ~= d^2
    error('QRLab:QSwitch:DimensionMismatch', ...
        'size(JN,1) must equal d^2. Received %d and %d.', size(JN, 1), d^2);
end

% System ordering convention used below:
%   input systems: 1,3,5 and output systems: 2,4,6.
ketI = MaxEntangled(d);
W1 = Tensor(ketI, ketI, ketI);
permW1 = PermuteSystems(W1, [1 4 5 2 3 6], [d d d d d d]);
WPlus = 0.5 * (W1 + permW1);
WMinus = 0.5 * (W1 - permW1);

JPlus = d^3 * PermuteSystems(WPlus * WPlus', [1 3 5 2 4 6], [d d d d d d]);
JMinus = d^3 * PermuteSystems(WMinus * WMinus', [1 3 5 2 4 6], [d d d d d d]);

insertion = PermuteSystems(Tensor(JN, JN, eye(d^2)), [5 2 4 1 3 6]);

linkPlus = PartialTranspose(JPlus, [2 3 4 5], [d d d d d d]) * insertion;
JoutPlus = PartialTrace(linkPlus, [2 3 4 5], [d d d d d d]);

linkMinus = PartialTranspose(JMinus, [2 3 4 5], [d d d d d d]) * insertion;
JoutMinus = PartialTrace(linkMinus, [2 3 4 5], [d d d d d d]);
end
