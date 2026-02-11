function probability = SimulateCoherentChannelProb(target_channel, resource_state, free_op, error_tolerance, varargin)
    % Find the maximal success probability :math:`p` to simulate the target channel
    % using free operations :math:`\mathcal{M}` and a resource state :math:`\omega`,
    % up to an allowed diamond-norm error :math:`\epsilon`.
    %
    % .. math::
    %    \max_{\mathcal{M}} \left\{ p \;\middle|\; \mathcal{M}(\omega \otimes \cdot)
    %    = p\,\mathcal{L}(\cdot) + (1-p)\,\mathcal{R}(\cdot),\;
    %    \|\mathcal{L} - \mathcal{N}\|_\diamond \le \epsilon \right\}
    %
    % where :math:`\mathcal{N}` is the target channel, :math:`\mathcal{L}` is the implemented channel,
    % and :math:`\mathcal{R}` is an arbitrary CPTP "rubbish" channel.
    %
    % Args:
    %     target_channel (matrix): Choi matrix :math:`J_\mathcal{N} \in \mathbb{C}^{(d_i d_o)\times(d_i d_o)}` of the target channel :math:`\mathcal{N}`.
    %     resource_state (matrix): Density matrix :math:`\omega \in \mathbb{C}^{d_r\times d_r}` of the given resource state.
    %     free_op (numeric): Choice of free operation :math:`\mathcal{M}`; `0` for MIO, `1` for DIO.
    %     error_tolerance (numeric): Allowed error :math:`\epsilon \ge 0` measured in diamond norm.
    %     varargin (list): Channel dimensions, default `[d_i, d_o]` with `d_i = d_o = \sqrt{\text{size}(J_\mathcal{N},1)}`.
    %
    % Returns:
    %     probability (numeric): Maximal success probability :math:`p \in [0,1]` for the simulation.
    %
    % Note:
    %     Zhao, B., Ito, K., & Fujii, K. (2024).
    %     Probabilistic channel simulation using coherence.
    %     arXiv preprint arXiv:2404.06775.

% set optional argument defaults
dim = opt_args({[sqrt(length(target_channel)), sqrt(length(target_channel))]}, varargin{:});
dim_i = dim(1);
dim_o = dim(2);
dim_r = length(resource_state);
JN = target_channel;
eps = error_tolerance;
%% SDP
cvx_begin sdp quiet
    variable JM(dim_r*dim_i*dim_o,dim_r*dim_i*dim_o) hermitian
    variable Z(dim_i*dim_o,dim_i*dim_o) hermitian
    variable t

    JE = PartialTrace(JM*kron(resource_state.', eye(dim_i*dim_o)), 1, [dim_r,dim_i*dim_o]);
    minimize t
    subject to
        JM >= 0;
        PartialTrace(JM, 3, [dim_r,dim_i,dim_o]) <= t * eye(dim_r*dim_i);
        PartialTrace(JE, 2, [dim_i,dim_o]) == eye(dim_i);
        Z >= 0;
        Z >= JN-JE;
        eps*eye(dim_i) >= PartialTrace(Z,2,[dim_i, dim_o]);
        %%%%% MIO %%%%%%%%%
        for i = 1:dim_r*dim_i
            PartialTrace(JM*kron(KetBra(dim_r*dim_i,i,i), eye(dim_o)),1,[dim_r*dim_i, dim_o])...
                == diag(diag(PartialTrace(JM*kron(KetBra(dim_r*dim_i,i,i), eye(dim_o)),1,[dim_r*dim_i, dim_o])));
        end

        if free_op == 1
            %%%%% DIO %%%%%%%%%
            for i = 1:dim_r*dim_i
                for j = 1:dim_r*dim_i
                    if i ~= j
                        diag(diag(PartialTrace(JM*kron(KetBra(dim_r*dim_i, i, j).', eye(dim_o)), 1, [dim_r*dim_i,dim_o]))) == zeros(dim_o,dim_o);
                    end
                end
            end
        end
cvx_end
probability = 1/t;
