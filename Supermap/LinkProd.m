function Jout = LinkProd(JA, JB, DIM)
    % Link Product of two Quantum channels, where A_out of JA is linked with
    % the B_in of JB.
    %
    % :Required packages:
    %   `QETLAB  <http://www.qetlab.com/Main_Page>`_
    %
    %
    % .. math::
    %
    %   J_{\mathcal{B} \circ \mathcal{A}} = J_{\mathcal{A}} * J_{\mathcal{B}} = Tr_1[(J_{\mathcal{A}} \otimes I_2)
    %   \cdot (I_0 \otimes J_{\mathcal{B}}^{T_1})],
    %
    % Args:
    %     JA (numeric): The choi matrix of the quantum channel A.
    %     JB (numeric): The choi matrix of the quantum channel B.
    %     DIM (int): The dimensions of channel A and channel B.
    %
    % Returns:
    %     numeric: Resulting Choi matrix of the link product of two Choi matrices JA and JB.
    %
    % Raises:
    %     error: If the dimension of the input state does not match with the pure stabilizer state matrix, an error is raised.
    %
    % :Examples:
    %   .. code-block:: matlab
    %
    %       % Link product of two Choi matrices JA and JB:
    %       Jout = LinkProd(JA, JB, [Ain, Aout, Bin, Bout]);

    validateattributes(JA, {'numeric'}, {'2d','nonempty'}, mfilename, 'JA', 1);
    validateattributes(JB, {'numeric'}, {'2d','nonempty'}, mfilename, 'JB', 2);
    validateattributes(DIM, {'numeric'}, {'vector','numel',4,'integer','positive'}, mfilename, 'DIM', 3);

    Ain = DIM(1);
    Aout = DIM(2);
    Bin = DIM(3);
    Bout = DIM(4);

    expectedJA = Ain * Aout;
    expectedJB = Bin * Bout;

    if ~isequal(size(JA), [expectedJA, expectedJA])
        error('QRLab:Supermap:InvalidJA', ...
            'JA must be a square matrix of size %d-by-%d for DIM=[%d %d %d %d].', ...
            expectedJA, expectedJA, Ain, Aout, Bin, Bout);
    end

    if ~isequal(size(JB), [expectedJB, expectedJB])
        error('QRLab:Supermap:InvalidJB', ...
            'JB must be a square matrix of size %d-by-%d for DIM=[%d %d %d %d].', ...
            expectedJB, expectedJB, Ain, Aout, Bin, Bout);
    end

    if Aout ~= Bin
        error('QRLab:Supermap:DimensionMismatch', ...
            'Output dimension of channel A (%d) must match input dimension of channel B (%d).', Aout, Bin);
    end

    % Link A_out and B_in.
    link = kron(JA, eye(Bout)) * kron(eye(Ain), PartialTranspose(JB, 1, [Bin, Bout]));
    Jout = PartialTrace(link, 2, [Ain, Aout, Bout]);
end
