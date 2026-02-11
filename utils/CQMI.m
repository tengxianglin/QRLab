function val = CQMI(rhoABC, dim)
%CQMI Compute conditional quantum mutual information I(A:C|B).
%   VAL = CQMI(RHOABC, DIM) computes
%       I(A:C|B) = H(AB) + H(BC) - H(B) - H(ABC)
%   for a tripartite density operator RHOABC with subsystem dimensions
%   DIM = [dA dB dC].
%
%   Syntax
%   ------
%   val = CQMI(rhoABC, dim)
%
%   Inputs
%   ------
%   rhoABC : square numeric matrix
%       Tripartite density matrix in ABC ordering.
%   dim : 1x3 integer vector
%       Subsystem dimensions [dA, dB, dC].
%
%   Output
%   ------
%   val : double scalar
%       Conditional quantum mutual information in bits.
%
%   Example
%   -------
%   rho = eye(8) / 8;
%   value = CQMI(rho, [2 2 2]);

arguments
    rhoABC (:,:) {mustBeNumeric}
    dim (1,3) {mustBeInteger, mustBePositive}
end

if size(rhoABC, 1) ~= size(rhoABC, 2)
    error('QRLab:CQMI:NonSquareMatrix', 'rhoABC must be a square matrix.');
end

expectedDim = prod(dim);
if size(rhoABC, 1) ~= expectedDim
    error('QRLab:CQMI:DimensionMismatch', ...
        'size(rhoABC,1) must equal prod(dim). Received %d and %d.', ...
        size(rhoABC, 1), expectedDim);
end

dA = dim(1);
dB = dim(2);
dC = dim(3);

rhoAB = PartialTrace(rhoABC, 3, [dA, dB, dC]);
rhoBC = PartialTrace(rhoABC, 1, [dA, dB, dC]);
rhoB = PartialTrace(rhoBC, 2, [dB, dC]);

val = Entropy(rhoAB) + Entropy(rhoBC) - Entropy(rhoB) - Entropy(rhoABC);
end
