function M = KetBra(dim, i, j)
%KETBRA Construct a matrix representation of |i><j|.
%   M = KETBRA(DIM, I, J) returns a DIM-by-DIM matrix with a single
%   non-zero element at row I and column J.
%
% Args:
%     dim (numeric): Dimension of the matrix.
%     i (numeric): The index of ket.
%     j (numeric): The index of bra.
%
% Returns:
%     numeric: The matrix for |i><j|.

validateattributes(dim, {'numeric'}, {'scalar','integer','>=',1}, mfilename, 'dim', 1);
validateattributes(i, {'numeric'}, {'scalar','integer','>=',1,'<=',dim}, mfilename, 'i', 2);
validateattributes(j, {'numeric'}, {'scalar','integer','>=',1,'<=',dim}, mfilename, 'j', 3);

M = zeros(dim, dim);
M(i, j) = 1;
end
