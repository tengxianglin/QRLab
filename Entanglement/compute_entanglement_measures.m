function result = compute_entanglement_measures(rho_in, opts)
%COMPUTE_ENTANGLEMENT_MEASURES Evaluate selected entanglement measures.
%   RESULT = COMPUTE_ENTANGLEMENT_MEASURES(RHO_IN) evaluates default
%   measures for a bipartite state matrix.
%
%   RESULT = COMPUTE_ENTANGLEMENT_MEASURES(RHO_IN, OPTS) allows control of
%   dimensions, selected measures, preprocessing behavior, and output type.
%
% Inputs:
%   rho_in : Density matrix (state) or channel Choi matrix.
%   opts   : struct with optional fields:
%            .dims            - [d_A, d_B]; if empty, infer square dims (default: []).
%            .measures        - cell array of measure names to evaluate
%                               (default: {'LogNeg','RainsBound','MaxRainsEntropy','TemperedLogNeg'}).
%            .custom_measures - struct; each field is a label, each value a
%                               function handle f(rho, dims) -> scalar.
%            .return_table    - true/false; return a table if true (default: false).
%            .normalize_trace - true/false; Hermitize and normalize if true (default: true).
%
% Output:
%   result : struct with fields per measure (value, elapsed) plus a meta field,
%            or a table with columns Measure, Value, Elapsed when opts.return_table is true.

validateattributes(rho_in, {'numeric'}, {'2d','nonempty'}, mfilename, 'rho_in', 1);
if size(rho_in, 1) ~= size(rho_in, 2)
    error('QRLab:Entanglement:NonSquareInput', 'rho_in must be a square matrix.');
end

if nargin < 2 || isempty(opts)
    opts = struct();
elseif ~isstruct(opts)
    error('QRLab:Entanglement:InvalidOptions', 'opts must be a struct when provided.');
end

% ---------- Option handling ----------
if ~isfield(opts, 'dims');            opts.dims = []; end
if ~isfield(opts, 'measures');        opts.measures = {'LogNeg','RainsBound','MaxRainsEntropy','TemperedLogNeg'}; end
if ~isfield(opts, 'custom_measures'); opts.custom_measures = struct(); end
if ~isfield(opts, 'return_table');    opts.return_table = false; end
if ~isfield(opts, 'normalize_trace'); opts.normalize_trace = true; end

if ~iscellstr(opts.measures) && ~(iscell(opts.measures) && all(cellfun(@(x) isstring(x) || ischar(x), opts.measures)))
    error('QRLab:Entanglement:InvalidMeasureList', 'opts.measures must be a cell array of measure names.');
end
if ~islogical(opts.return_table) || ~isscalar(opts.return_table)
    error('QRLab:Entanglement:InvalidReturnTableOption', 'opts.return_table must be a scalar logical.');
end
if ~islogical(opts.normalize_trace) || ~isscalar(opts.normalize_trace)
    error('QRLab:Entanglement:InvalidNormalizeOption', 'opts.normalize_trace must be a scalar logical.');
end
if ~isstruct(opts.custom_measures)
    error('QRLab:Entanglement:InvalidCustomMeasures', 'opts.custom_measures must be a struct of function handles.');
end

if ~isempty(opts.dims)
    validateattributes(opts.dims, {'numeric'}, {'vector','numel',2,'integer','positive'}, mfilename, 'opts.dims');
end

t_start = tic;

% ---------- preprocess ----------
rho = rho_in;
if opts.normalize_trace
    rho = (rho + rho') / 2;
    tr_val = trace(rho);
    if abs(tr_val) <= eps
        warning('QRLab:Entanglement:NearZeroTrace', ...
            'Trace is near zero during normalization; matrix is left unscaled.');
    else
        rho = rho / tr_val;
    end
end

% ---------- Dimension inference ----------
if isempty(opts.dims)
    d = sqrt(size(rho, 1));
    if abs(d - round(d)) > 1e-10
        error('QRLab:Entanglement:DimensionInferenceFailed', ...
            'Automatic dimension inference failed: matrix size is not a perfect square. Specify opts.dims manually.');
    end
    dims = [round(d), round(d)];
else
    dims = opts.dims;
end

if prod(dims) ~= size(rho, 1)
    error('QRLab:Entanglement:DimensionMismatch', ...
        'prod(opts.dims) must match matrix dimension. Received dims [%d %d] for %d-by-%d matrix.', ...
        dims(1), dims(2), size(rho, 1), size(rho, 2));
end

% ---------- Built-in measure map ----------
available.LogNeg          = @(state, d) LogNeg(state, d);
available.RainsBound      = @(state, d) RainsBound(state, d);
available.MaxRainsEntropy = @(state, d) MaxRains(state, d);
available.TemperedLogNeg  = @(state, d) TempLogNeg(state, d);

% ---------- Merge custom measures ----------
measure_map = available;
user_fields = fieldnames(opts.custom_measures);
for k = 1:numel(user_fields)
    name = user_fields{k};
    fn = opts.custom_measures.(name);
    if ~isa(fn, 'function_handle')
        error('QRLab:Entanglement:InvalidCustomMeasure', ...
            'Custom measure "%s" must be a function handle f(rho, dims).', name);
    end
    measure_map.(name) = fn;
end

% ---------- Evaluation ----------
measures_requested = cellfun(@char, opts.measures, 'UniformOutput', false);
result_struct = struct();
for idx = 1:numel(measures_requested)
    name = measures_requested{idx};
    if ~isfield(measure_map, name)
        warning('QRLab:Entanglement:UnknownMeasure', ...
            'Measure "%s" is not registered and will be skipped.', name);
        continue;
    end

    fn = measure_map.(name);
    t_local = tic;
    value = fn(rho, dims);
    result_struct.(name) = struct('value', value, 'elapsed', toc(t_local));
end

result_struct.meta = struct( ...
    'dims', dims, ...
    'trace', trace(rho), ...
    'elapsed_total', toc(t_start));

% ---------- Output ----------
if opts.return_table
    measure_names = fieldnames(result_struct);
    measure_names = measure_names(~strcmp(measure_names, 'meta'));
    values = zeros(numel(measure_names), 1);
    elapsed = zeros(numel(measure_names), 1);
    for k = 1:numel(measure_names)
        m = measure_names{k};
        values(k) = result_struct.(m).value;
        elapsed(k) = result_struct.(m).elapsed;
    end
    result = table(measure_names, values, elapsed, ...
        'VariableNames', {'Measure', 'Value', 'Elapsed'});
else
    result = result_struct;
end
end
