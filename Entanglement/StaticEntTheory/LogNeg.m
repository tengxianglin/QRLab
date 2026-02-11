function val = LogNeg(rho, varargin)
%LOGNEG Compute the logarithmic negativity of a bipartite state.
%   VAL = LOGNEG(RHO) assumes equal local dimensions inferred from RHO.
%   VAL = LOGNEG(RHO, DIMS) uses subsystem dimensions DIMS = [dA dB].
%
%   Inputs
%   ------
%   rho : square numeric matrix
%       Bipartite density matrix.
%   dims : 1x2 integer vector (optional)
%       Subsystem dimensions [dA dB].
%
%   Output
%   ------
%   val : double scalar
%       Logarithmic negativity, log2(||rho^{T_B}||_1).

if size(rho, 1) ~= size(rho, 2)
    error('QRLab:LogNeg:NonSquareInput', 'rho must be a square matrix.');
end

if nargin < 2
    dLocal = sqrt(size(rho, 1));
    if abs(dLocal - round(dLocal)) > 1e-10
        error('QRLab:LogNeg:DimensionInferenceFailed', ...
            'Failed to infer equal local dimensions; pass dims explicitly as [dA dB].');
    end
    dims = [round(dLocal) round(dLocal)];
else
    raw = varargin{1};
    if isvector(raw)
        dims = raw(:).';
        if numel(dims) == 1
            dims = [dims dims];
        end
    else
        warning('QRLab:LogNeg:DeprecatedSecondMatrixInput', ...
            ['Passing a matrix as the second input is deprecated and ignored. ', ...
             'Pass dimensions as [dA dB] instead.']);
        dLocal = sqrt(size(rho, 1));
        dims = [round(dLocal) round(dLocal)];
    end
end

if numel(dims) ~= 2 || any(dims < 1) || prod(dims) ~= size(rho, 1)
    error('QRLab:LogNeg:InvalidDimensions', ...
        'dims must be [dA dB] with prod(dims) == size(rho,1).');
end

dA = dims(1);
dB = dims(2);
dAB = dA * dB;

cvx_begin sdp quiet
    variable R(dAB, dAB) hermitian
    rhoTB = PartialTranspose(rho, 2, [dA, dB]);
    t = real(trace(rhoTB * R));
    maximize t
    subject to
        -eye(dAB) <= R <= eye(dAB);
cvx_end

val = log2(t);
end
