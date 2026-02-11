# User Guide

## 1. Overview

QRLab provides modular MATLAB functions for common quantum information tasks. Most functions are organized by resource-theory domain and can be called directly once QRLab and dependencies are added to the MATLAB path.

## 2. Typical workflow

1. Add dependencies (QETLAB, CVX, QRLab) to path.
2. Prepare input states/channels as numeric matrices.
3. Call domain-specific functions (for example `LogNeg`, `RobustnessCoherentState`, `QSwitch`).
4. Validate outputs using dimensions, positivity checks, and deterministic test scripts.

## 3. Quick examples

### Basis operator construction

```matlab
M = KetBra(4, 2, 3);
```

### Conditional quantum mutual information

```matlab
rho = eye(8) / 8;
value = CQMI(rho, [2 2 2]);
```

### Configurable measure dispatch

```matlab
rho = eye(4) / 4;
opts = struct();
opts.dims = [2 2];
opts.measures = {'TraceValue'};
opts.custom_measures.TraceValue = @(x,~) real(trace(x));
out = compute_entanglement_measures(rho, opts);
```

## 4. Dependency-aware usage notes

- Functions using semidefinite programming require CVX.
- Functions using operations such as `PartialTrace` and `PartialTranspose` require QETLAB.
- Use try/check patterns in scripts to degrade gracefully when optional dependencies are unavailable.

## 5. Running examples and tests

- Examples: run scripts under `examples/`.
- Tests: run `runtests_qrlab` from repository root.
