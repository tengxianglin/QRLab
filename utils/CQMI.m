% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
function [val] = CQMI(rhoABC, dim)
    % .. math::
    %
    %     I(A:C|B) = I(A:B) + I(B:C) - H(B) - H(ABC)
    % 
    % Args:
    %     rhoABC (numeric): The density matrix of the tripartite state.
    %     dim (numeric): The dimensions of subsystems A, B and C.
    % 
    % Returns:
    %     numeric: :math:`I(A:C|B)` conditional mutual information.

dA = dim(1);
dB = dim(2);
dC = dim(3);

rhoAB = PartialTrace(rhoABC, 3, [dA, dB, dC]);
rhoBC = PartialTrace(rhoABC, 1, [dA, dB, dC]);
rhoB  = PartialTrace(rhoBC, 2, [dB, dC]);

val = Entropy(rhoAB) + Entropy(rhoBC) - Entropy(rhoB) - Entropy(rhoABC);
end

