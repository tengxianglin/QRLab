function state = FlagPoleState(dim, p)
% Construct a flag-pole state in the computational basis.
%
% .. math::
%    \ket{\psi} = \sqrt{p}\,\ket{0} + \sum_{i=1}^{d-1} \sqrt{\frac{1-p}{d-1}}\,\ket{i},
%
% so that :math:`\rho = \ket{\psi}\!\bra{\psi}` is a pure state.
%
% Args:
%     dim (numeric): System dimension :math:`d \ge 2`.
%     p (numeric): Flag amplitude :math:`p \in [0,1]`.
%
% Returns:
%     state (matrix): Density matrix :math:`\rho = \ket{\psi}\!\bra{\psi}` of the flag-pole state.

ket = [sqrt(p)];
for i = 1:dim-1;
    ket(end + 1) = sqrt((1-p)/(dim-1));
end

state = ket.'*ket;