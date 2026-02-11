# QRLab User Guide

## Overview
QRLab is a MATLAB toolbox for quantum resource theory workflows, including entanglement, coherence, magic, supermaps, and quasi-probability modules.

## Prerequisites
- MATLAB desktop
- QETLAB 0.9 on MATLAB path
- CVX 2.1 initialized with `cvx_setup`

## Getting Started
1. Add dependencies and QRLab to your path:
   ```matlab
   addpath(genpath('path/to/QETLAB-0.9'));
   addpath(genpath('path/to/QRLab'));
   ```
2. Run a smoke example:
   ```matlab
   rho = MaxEntangled(2) * MaxEntangled(2)';
   ln = LogNeg(rho);
   fprintf('Logarithmic negativity: %.6f\n', ln);
   ```

## Core Workflows

### 1) Evaluate multiple entanglement measures in one call
```matlab
rho = MaxEntangled(2) * MaxEntangled(2)';
opts = struct();
opts.dims = [2 2];
opts.measures = {'LogNeg', 'RainsBound'};
res = compute_entanglement_measures(rho, opts);
disp(res.LogNeg.value);
```

### 2) Build a computational basis operator
```matlab
M = KetBra(4, 2, 3);  % |2><3|
```

### 3) Generate a flag-pole coherence state
```matlab
rho = FlagPoleState(5, 0.6);
trace(rho)  % should be 1
```

## Examples Folder
Use the scripts in `examples/` for quick demonstrations:
- `examples/example_basic_states.m`
- `examples/example_entanglement_dispatcher.m`

## Troubleshooting
- If `PartialTrace`, `PartialTranspose`, or `MaxEntangled` are unresolved, confirm QETLAB path setup.
- If CVX-based measures fail, run `cvx_setup` and ensure CVX 2.1 is active.
- For dependency-sensitive tests, use `runtests_qrlab` to see skipped tests with reasons.
