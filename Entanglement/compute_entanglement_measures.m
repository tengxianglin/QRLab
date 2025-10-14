function result = compute_entanglement_measures(rho_in, opts)
% COMPUTE_ENTANGLEMENT_MEASURES
%  Dispatcher for a set of common entanglement measures. Supports selective
%  evaluation, custom extensions, basic preprocessing (Hermitization, trace
%  normalization), and optional tabular output.
%
% Inputs:
%   rho_in : Density matrix (state) or channel Choi matrix.
%   opts   : struct with optional fields:
%            .dims            - [d_A, d_B]; if empty, infer square dims (default: []).
%            .measures        - cell array of measure names to evaluate
%                               (default: {'LogNeg','RainsBound','MaxRainsEntropy','TemperedLogNeg'}).
%            .custom_measures - struct; each field is a label, each value a
%                               function handle f(rho, dims) returning a scalar.
%            .return_table    - true/false; if true, return a table (default: false).
%            .normalize_trace - true/false; if true, Hermitize and normalize (default: true).
%
% Output:
%   result : struct with fields per measure (value, elapsed) + meta, or a table
%            with columns Measure, Value, Elapsed when opts.return_table is true.

% ---------- Option handling ----------
if ~exist('opts','var') || isempty(opts)
    opts = struct();
end
if ~isfield(opts,'dims');            opts.dims = []; end
if ~isfield(opts,'measures');        opts.measures = {'LogNeg','RainsBound','MaxRainsEntropy','TemperedLogNeg'}; end
if ~isfield(opts,'custom_measures'); opts.custom_measures = struct(); end
if ~isfield(opts,'return_table');    opts.return_table = false; end
if ~isfield(opts,'normalize_trace'); opts.normalize_trace = true; end

t_start = tic;

% ---------- preprocess ----------
rho = rho_in;
if opts.normalize_trace
    rho = (rho + rho')/2;        % Hermitian 
    tr_val = trace(rho);
    if abs(tr_val) > eps
        rho = rho / tr_val;      % Normalize
    end
end

% ---------- Dimension inference ----------
if isempty(opts.dims)
    d = sqrt(max(size(rho)));
    if abs(d - round(d)) > 1e-10
        error('Automatic dimension inference failed: matrix size is not a perfect square. Specify opts.dims manually.');
    end
    dims = round(d) * [1, 1];
else
    dims = opts.dims;
end
if isempty(dims)
    error('System dimensions are undefined. Please set opts.dims.');
end

% ---------- Built-in measure map ----------
available.LogNeg            = @(rho,d) LogNeg(rho, d);
available.RainsBound        = @(rho,d) RainsBound(rho, d);
available.MaxRainsEntropy   = @(rho,d) MaxRains(rho, d);
available.TemperedLogNeg    = @(rho,d) TempLogNeg(rho, d);

% ---------- Merge custom measures ----------
measure_map = available;
user_fields = fieldnames(opts.custom_measures);
for k = 1:numel(user_fields)
    name = user_fields{k};
    measure_map.(name) = opts.custom_measures.(name);
end

% ---------- Evaluation ----------
measures_requested = opts.measures;
result_struct = struct();
for idx = 1:numel(measures_requested)
    name = measures_requested{idx};
    if ~isfield(measure_map, name)
        warning('Measure %s is not registered and will be skipped.', name);
        continue;
    end
    fn = measure_map.(name);
    t_local = tic;
    value = fn(rho, dims);
    result_struct.(name) = struct('value', value, 'elapsed', toc(t_local));
end

result_struct.meta = struct(...
    'dims', dims, ...
    'trace', trace(rho), ...
    'elapsed_total', toc(t_start));

% ---------- Output ----------
if opts.return_table
    measure_names = fieldnames(result_struct);
    measure_names = measure_names(~strcmp(measure_names,'meta'));
    values  = zeros(numel(measure_names), 1);
    elapsed = zeros(numel(measure_names), 1);
    for k = 1:numel(measure_names)
        m = measure_names{k};
        values(k)  = result_struct.(m).value;
        elapsed(k) = result_struct.(m).elapsed;
    end
    result = table(measure_names, values, elapsed, ...
        'VariableNames', {'Measure','Value','Elapsed'});
else
    result = result_struct;
end
end