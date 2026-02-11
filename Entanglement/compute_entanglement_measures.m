function result = compute_entanglement_measures(rhoIn, opts)
%COMPUTE_ENTANGLEMENT_MEASURES Evaluate a configurable set of measures.
%   RESULT = COMPUTE_ENTANGLEMENT_MEASURES(RHOIN, OPTS) evaluates requested
%   entanglement-related metrics and returns either a struct or a table.
%
%   Syntax
%   ------
%   result = compute_entanglement_measures(rhoIn)
%   result = compute_entanglement_measures(rhoIn, opts)
%
%   Inputs
%   ------
%   rhoIn : square numeric matrix
%       Input density matrix (or compatible operator matrix).
%   opts : struct (optional)
%       Optional fields:
%       - dims            : [dA dB], inferred from size(rhoIn) if empty.
%       - measures        : cellstr of built-in/custom measure names.
%       - custom_measures : struct of function handles f(rho,dims) -> scalar.
%       - return_table    : logical, return table instead of struct.
%       - normalize_trace : logical, hermitize and normalize trace.
%
%   Output
%   ------
%   result : struct or table
%       Measure values and timing metadata.

arguments
    rhoIn (:,:) {mustBeNumeric}
    opts.dims (1,:) {mustBeInteger, mustBePositive} = []
    opts.measures cell = {'LogNeg','RainsBound','MaxRainsEntropy','TemperedLogNeg'}
    opts.custom_measures struct = struct()
    opts.return_table (1,1) logical = false
    opts.normalize_trace (1,1) logical = true
end

if size(rhoIn, 1) ~= size(rhoIn, 2)
    error('QRLab:ComputeEntanglementMeasures:NonSquareInput', ...
        'rhoIn must be a square matrix.');
end

tStart = tic;
rho = rhoIn;
if opts.normalize_trace
    rho = (rho + rho') / 2;
    trVal = trace(rho);
    if abs(trVal) <= eps
        error('QRLab:ComputeEntanglementMeasures:ZeroTrace', ...
            'Cannot normalize input with near-zero trace.');
    end
    rho = rho / trVal;
end

if isempty(opts.dims)
    d = sqrt(size(rho, 1));
    if abs(d - round(d)) > 1e-10
        error('QRLab:ComputeEntanglementMeasures:DimensionInferenceFailed', ...
            ['Automatic dimension inference failed. Set opts.dims ', ...
             'explicitly as [dA dB].']);
    end
    dims = [round(d), round(d)];
else
    dims = opts.dims;
end

if numel(dims) ~= 2 || prod(dims) ~= size(rho, 1)
    error('QRLab:ComputeEntanglementMeasures:DimensionMismatch', ...
        'opts.dims must contain two subsystem dimensions whose product matches size(rhoIn,1).');
end

available.LogNeg = @(state, dIn) LogNeg(state, dIn);
available.RainsBound = @(state, dIn) RainsBound(state, dIn);
available.MaxRainsEntropy = @(state, dIn) MaxRains(state, dIn);
available.TemperedLogNeg = @(state, dIn) TempLogNeg(state, dIn);

measureMap = available;
userFields = fieldnames(opts.custom_measures);
for k = 1:numel(userFields)
    name = userFields{k};
    candidate = opts.custom_measures.(name);
    if ~isa(candidate, 'function_handle')
        error('QRLab:ComputeEntanglementMeasures:InvalidCustomMeasure', ...
            'Custom measure "%s" must be a function handle.', name);
    end
    measureMap.(name) = candidate;
end

resultStruct = struct();
for idx = 1:numel(opts.measures)
    name = opts.measures{idx};
    if ~ischar(name) && ~isstring(name)
        error('QRLab:ComputeEntanglementMeasures:InvalidMeasureName', ...
            'Each measure name must be a character vector or string scalar.');
    end
    name = char(name);
    if ~isfield(measureMap, name)
        warning('QRLab:ComputeEntanglementMeasures:UnknownMeasure', ...
            'Measure "%s" is not registered and was skipped.', name);
        continue;
    end
    fn = measureMap.(name);
    tLocal = tic;
    value = fn(rho, dims);
    resultStruct.(name) = struct('value', value, 'elapsed', toc(tLocal));
end

resultStruct.meta = struct(...
    'dims', dims, ...
    'trace', trace(rho), ...
    'elapsed_total', toc(tStart));

if opts.return_table
    measureNames = fieldnames(resultStruct);
    measureNames = measureNames(~strcmp(measureNames, 'meta'));
    values = zeros(numel(measureNames), 1);
    elapsed = zeros(numel(measureNames), 1);
    for k = 1:numel(measureNames)
        m = measureNames{k};
        values(k) = resultStruct.(m).value;
        elapsed(k) = resultStruct.(m).elapsed;
    end
    result = table(measureNames, values, elapsed, ...
        'VariableNames', {'Measure', 'Value', 'Elapsed'});
else
    result = resultStruct;
end
end
