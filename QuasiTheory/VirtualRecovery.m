% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
function val = VirtualRecovery(rho, dim)

    % Compute the virtual recovery measure of a tripartite state :math:`\rho_{ABC}`.
    %
    % .. math::
    %
    %     R^v_{rec}(\rho_{ABC}) = \log\min\{c_1+c_2:(c_1\mathcal{N}_1 - c_2\mathcal{N}_2)(\rho_{AB}) = \rho_{ABC}, c_{1,2}\geq 0, \mathcal{N}_{1,2}\in\operatorname{CPTP}(B,B\otimes C)\}
    %
    % Args:
    %   rho (numeric): The density matrix of the tripartite state :math:`\rho_{ABC}`.
    %   dim (numeric): Dimension array :math:`[d_A, d_B, d_C]` for subsystems :math:`A,B,C`.
    %
    % Returns:
    %   numeric: The virtual recovery of the tripartite state (in bits).
    %
    % Raises:
    %   error: If either input/output dimension does not match, an error is raised.
    %
    % Note:
    %   Chen, Y. A., Zhu, C., He, K., Jing, M., & Wang, X. (2023). 
    %   Virtual Quantum Markov Chains. 
    %   arXiv preprint arXiv:2312.02031. Accepted to IEEE Transactions on Information Theory.

    da = dim(1);
    db = dim(2);
    dc = dim(3);
    
    JI = MaxEntangled(da, 0, 1) * MaxEntangled(da, 0, 1)' * eye(da^2) * da;
    
    cvx_begin sdp quiet
    variable JD1(db*db*dc, db*db*dc) hermitian
    variable JD2(db*db*dc, db*db*dc) hermitian
    variable p1
    variable p2
    JD = JD1 - JD2;
    cost = p1 + p2;
    
    JN = PermuteSystems(kron(JI, JD), [1 3 2 4], [da da db db*dc]);
    sigabc = ApplyMap(PartialTrace(rho, 3, [da, db, dc]), JN);
    
    minimize cost
    subject to
        JD1 >= 0; 
        PartialTrace(JD1, 2, [db db*dc]) == p1 * eye(db);
        JD2 >= 0; 
        PartialTrace(JD2, 2, [db db*dc]) == p2 * eye(db);
        sigabc == rhoabc;
    cvx_end

    val = log2(cost);
end

