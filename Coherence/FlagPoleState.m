function state = FlagPoleState(dim, p)
%FLAGPOLESTATE Construct a flag-pole pure state density matrix.
%   STATE = FLAGPOLESTATE(DIM, P) returns the density matrix
%   |psi><psi| where
%
%   .. math::
%      \ket{\psi} = \sqrt{p}\,\ket{0} + \sum_{i=1}^{d-1} \sqrt{\frac{1-p}{d-1}}\,\ket{i},
%
%   so that :math:`\rho = \ket{\psi}\!\bra{\psi}` is a pure state.
%
% Args:
%     dim (numeric): System dimension :math:`d \ge 2`.
%     p (numeric): Flag amplitude :math:`p \in [0,1]`.
%
% Returns:
%     state (matrix): Density matrix :math:`\rho = \ket{\psi}\!\bra{\psi}` of the flag-pole state.

validateattributes(dim, {'numeric'}, {'scalar','integer','>=',2}, mfilename, 'dim', 1);
validateattributes(p, {'numeric'}, {'scalar','real','>=',0,'<=',1}, mfilename, 'p', 2);

ampTail = sqrt((1 - p) / (dim - 1));
ket = [sqrt(p); ampTail * ones(dim - 1, 1)];
state = ket * ket.';
end
