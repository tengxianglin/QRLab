function matrix = UnitaryChannel(unitary)
    % UnitaryChannel Provide the Choi matrix of a unitary channel.
    %
    % .. math::
    %    J_{\mathcal{U}} = d\,(\mathbb{I}\otimes U)\,|\Phi_d\rangle\langle\Phi_d|\,
    %    (\mathbb{I}\otimes U^\dagger),
    %
    % where :math:`|\Phi_d\rangle = \tfrac{1}{\sqrt{d}}\sum_{i=0}^{d-1} |i\rangle\otimes|i\rangle`
    % is the maximally entangled state and :math:`d` is the input (and output) dimension.
    %
    % Args:
    %     unitary (numeric): A :math:`d\times d` unitary matrix :math:`U`. (Assumed unitary; no validation performed.)
    %
    % Returns:
    %     numeric: Choi matrix :math:`J_{\mathcal{U}} \in \mathbb{C}^{d^2 \times d^2}` of the unitary channel :math:`\mathcal{U}(\cdot)=U(\cdot)U^\dagger`.
    %
    % Note:
    %     Uses the (unnormalized) Choi–Jamiołkowski representation consistent with the project convention (factor :math:`d` included).
    
    dim = length(unitary);
    max_entangled_state = dim*MaxEntangled(dim) * MaxEntangled(dim)';
    matrix = kron(eye(dim), unitary) * max_entangled_state * kron(eye(dim), unitary)';
end