function Jout = LinkProd(JA, JB, dim)
%LINKPROD Compute the link product of two channel Choi matrices.
%   JOUT = LINKPROD(JA, JB, DIM) links the output subsystem of channel A to
%   the input subsystem of channel B. DIM = [Ain, Aout, Bin, Bout].
%
%   Syntax
%   ------
%   Jout = LinkProd(JA, JB, dim)
%
%   Inputs
%   ------
%   JA : square numeric matrix
%       Choi matrix of channel A.
%   JB : square numeric matrix
%       Choi matrix of channel B.
%   dim : 1x4 integer vector
%       [Ain, Aout, Bin, Bout]. Requires Aout == Bin.
%
%   Output
%   ------
%   Jout : numeric matrix
%       Choi matrix of the composed channel B o A.
%
%   Notes
%   -----
%   Requires QETLAB functions PartialTranspose and PartialTrace.

arguments
    JA (:,:) {mustBeNumeric}
    JB (:,:) {mustBeNumeric}
    dim (1,4) {mustBeInteger, mustBePositive}
end

if size(JA, 1) ~= size(JA, 2) || size(JB, 1) ~= size(JB, 2)
    error('QRLab:LinkProd:NonSquareInput', 'JA and JB must be square matrices.');
end

Ain = dim(1);
Aout = dim(2);
Bin = dim(3);
Bout = dim(4);

if Aout ~= Bin
    error('QRLab:LinkProd:IncompatibleDimensions', ...
        'Aout must equal Bin. Received Aout=%d and Bin=%d.', Aout, Bin);
end

if size(JA, 1) ~= Ain * Aout
    error('QRLab:LinkProd:JAInconsistentSize', ...
        'size(JA,1) must equal Ain*Aout. Received %d and %d.', size(JA, 1), Ain * Aout);
end
if size(JB, 1) ~= Bin * Bout
    error('QRLab:LinkProd:JBInconsistentSize', ...
        'size(JB,1) must equal Bin*Bout. Received %d and %d.', size(JB, 1), Bin * Bout);
end

link = kron(JA, eye(Bout)) * kron(eye(Ain), PartialTranspose(JB, 1, [Bin, Bout]));
Jout = PartialTrace(link, 2, [Ain, Aout, Bout]);
end
