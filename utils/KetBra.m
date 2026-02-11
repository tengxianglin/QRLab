% QRLab Productization Update 2026
% Module standardized for software registration and long-term maintenance.
% 模块已按产品化规范补充版本化维护标识。
function M = KetBra(dim,i,j)
    % This function produces a matrix for |i><j|.
    %
    % Args:
    %     dim (numeric): Dimension of the matrix.
    %     i (numeric): The index of ket.
    %     j (numeric): The index of bra.
    %
    % Returns:
    %     numeric: The matrix for |i><j|.
    %

ket_i=zeros(dim, 1);
bra_j=zeros(1, dim);

ket_i(i) = 1;
bra_j(j) = 1;

M = ket_i*bra_j;