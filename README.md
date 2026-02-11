# QRLab

QRLab is a MATLAB toolbox for quantum information processing and quantum resource theory research workflows, with modules covering entanglement, coherence, magic, quasi-probability methods, supermaps, and seesaw optimization.

## Features

- Entanglement analysis (static and dynamic measures, capacity utilities).
- Coherence quantification and coherent-channel simulation routines.
- Magic-state and channel-magic tooling for qubit and qudit settings.
- Quasi-probability error mitigation and decomposition tools.
- Supermap utilities including quantum switch and link products.
- Seesaw-based optimization examples for non-convex quantum tasks.

## MATLAB and dependency requirements

- MATLAB: R2021b or newer recommended.
- Required external package: [QETLAB](https://qetlab.com/).
- Required optimization package for CVX-based routines: [CVX](https://cvxr.com/cvx/) 2.x.
- Optional package for selected magic-channel routines: [channel_magic](https://github.com/jamesrseddon/channel_magic).

## Installation

1. Clone this repository.
2. Install QETLAB and CVX.
3. Add all required folders to your MATLAB path:

```matlab
addpath(genpath('/path/to/QETLAB-0.9'));
addpath(genpath('/path/to/QRLab'));
savepath;
```

4. Initialize CVX once:

```matlab
cd /path/to/cvx
cvx_setup
```

## Quick start

```matlab
% Basic utility smoke check
M = KetBra(2, 1, 2);
assert(M(1,2) == 1);

% Conditional mutual information for maximally mixed 3-qubit state
rho = eye(8) / 8;
v = CQMI(rho, [2 2 2]);
disp(v);
```

## Minimal runnable example

Run:

```matlab
run(fullfile('examples', 'example_basic_utils.m'))
```

## Folder structure

- `Entanglement/` - entanglement measures and capacity functions.
- `Coherence/` - coherence measures and channel simulation tools.
- `Magic/` - magic-state and channel-related routines.
- `QuasiTheory/` - quasi-probability and error-mitigation utilities.
- `Supermap/` - link product and quantum switch implementations.
- `utils/` - shared helper functions.
- `examples/` - lightweight runnable usage examples.
- `tests/` - `matlab.unittest`-based regression and smoke tests.
- `docs/` - product-oriented user/developer/software documentation.

## Getting help / troubleshooting

- Validate path setup:

```matlab
which KetBra -all
which LogNeg -all
which PartialTrace -all
```

- If CVX-based functions fail, ensure `cvx_setup` has been executed and `cvx_begin` is available.
- If QETLAB functions are unresolved, re-check your QETLAB installation and path order.
- Use `runtests_qrlab` to run the project test suite and inspect skipped tests.

## Citation

If you use QRLab in academic work, please cite this repository and include a version/tag reference when possible.

## License

Refer to repository licensing terms and institutional usage policies before redistribution.
