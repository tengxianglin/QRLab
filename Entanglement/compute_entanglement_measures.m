function result = compute_entanglement_measures(rho_in, opts)
% COMPUTE_ENTANGLEMENT_MEASURES
%  Quick dispatcher for entanglement measures. Covers several commonly used
%  indicators, supports selective evaluation, and allows custom extensions.
%
% Inputs:
%   rho_in : density matrix or quantum channel Choi matrix
%   opts   : struct with optional fields:
%            .dims            - subsystem dimensions (default: auto infer)
%            .measures        - cell array of target measure names
%            .custom_measures - struct; each field name is a measure label,
%                               each value is a function handle f(rho, dims)
%            .return_table    - true/false, convert output to table
%            .normalize_trace - true/false, normalize trace automatically
%
% Output:
%   result : struct or table containing values and meta data

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