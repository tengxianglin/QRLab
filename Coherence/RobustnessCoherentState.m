function C_R = RobustnessCoherentState(rho)
    % Compute the robustness of coherence of a quantum state :math:`\rho`.
    %
    % .. math::
    %    1 + C_R(\rho) = \min_{\sigma}\{\lambda \,\mid\, \rho \le \lambda \sigma\},
    %
    % where :math:`\sigma` is an incoherent (diagonal) state in the reference basis.
    %
    % Args:
    %     rho (matrix): Density matrix :math:`\rho \in \mathbb{C}^{d\times d}` (positive semidefinite, :math:`\mathrm{Tr}\,\rho=1`).
    %
    % Returns:
    %     C_R (numeric): Robustness of coherence :math:`C_R(\rho) \ge 0`.
    %
    % Note:
    %     Napoli, C., Bromley, T. R., Cianciaruso, M., Piani, M., Johnston, N., & Adesso, G. (2016).
    %     Robustness of coherence: an operational and observable measure of quantum coherence.
    %     Physical Review Letters, 116(15), 150502.

dim = length(rho);
cvx_begin sdp quiet
    variable M(dim,dim) hermitian
    variable s
    minimize s
    subject to
        s >= 0;
        rho <= M;
        trace(M) == 1 + s;
        M >= 0;
        M == diag(diag(M)); % incoherent (diagonal)
cvx_end
C_R = s;
end