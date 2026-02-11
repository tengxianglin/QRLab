function M = KetBra(dim, i, j)
%KETBRA Construct the matrix |i><j| in a finite-dimensional Hilbert space.
%   M = KETBRA(DIM, I, J) returns a DIM-by-DIM matrix with a 1 in entry
%   (I, J) and zeros elsewhere.
%
%   Syntax
%   ------
%   M = KetBra(dim, i, j)
%
%   Inputs
%   ------
%   dim : positive integer scalar
%       Dimension of the Hilbert space.
%   i : positive integer scalar
%       Basis index for the ket |i>.
%   j : positive integer scalar
%       Basis index for the bra <j|.
%
%   Output
%   ------
%   M : double matrix
%       Rank-1 basis operator |i><j|.
%
%   Example
%   -------
%   M = KetBra(3, 1, 2);
%   % M(1,2) == 1 and all other entries are zero.

arguments
    dim (1,1) {mustBeInteger, mustBePositive}
    i   (1,1) {mustBeInteger, mustBePositive}
    j   (1,1) {mustBeInteger, mustBePositive}
end

if i > dim || j > dim
    error('QRLab:KetBra:IndexOutOfRange', ...
        'Indices i and j must satisfy 1 <= i,j <= dim. Received dim=%d, i=%d, j=%d.', ...
        dim, i, j);
end

M = zeros(dim, dim);
M(i, j) = 1;
end
