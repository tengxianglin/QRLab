function C_R = RobustnessCoherentChannel(channel, varargin)
    % Compute the robustness of coherence of a quantum channel in Choi form.
    %
    % .. math::
    %    1 + C_R(\mathcal{N}) = \min_{\mathcal{M}}\{\lambda \,\mid\, \mathcal{N} \le \lambda \mathcal{M}\},
    %
    % where :math:`\mathcal{M}` ranges over maximally incoherent operations (MIO).
    %
    % Args:
    %     channel (matrix): Choi matrix :math:`J_\mathcal{N} \in \mathbb{C}^{(d_i d_o)\times(d_i d_o)}` of the input channel :math:`\mathcal{N}`.
    %     varargin (list): Channel dimensions, default `[d_i, d_o]` with `d_i = d_o = \sqrt{\text{size}(J_\mathcal{N},1)}`.
    %
    % Returns:
    %     C_R (numeric): Robustness of coherence :math:`C_R(\mathcal{N}) \ge 0` for the input channel.
    %
    % Note:
    %     Díaz, M. G., Fang, K., Wang, X., Rosati, M., Skotiniotis, M., Calsamiglia, J., & Winter, A. (2018).
    %     Using and reusing coherence to realize quantum processes.
    %     Quantum, 2, 100.


% set optional argument defaults
dim = opt_args({[sqrt(length(channel)), sqrt(length(channel))]}, varargin{:});
d_i = dim(1);
d_o = dim(2);
JN = channel;

cvx_begin sdp quiet

    variable JM(d_i*d_o, d_i*d_o) hermitian
    variable s

    minimize s
    subject to
        JM >= 0;
        PartialTrace(JM,2, [d_i,d_o]) == (1+s)*eye(d_i)
        s >= 0;
        JN <= JM;
        % MIO constraints
        for i = 1:d_i
        PartialTrace(JM*kron(KetBra(d_i,i,i), eye(d_o)),1,[d_i, d_o])...
            == diag(diag(PartialTrace(JM*kron(KetBra(d_i,i,i), eye(d_o)),1,[d_i, d_o])));
        end
cvx_end
C_R = s;

end