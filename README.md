# QRLab

QRLab is a MATLAB toolbox for quantum information processing and quantum resource theory research.

## Features
- High-level modules for entanglement, coherence, magic, quasi-probability error mitigation, supermaps, and seesaw algorithms.

### Entanglement Theory
- Static measures: Tempered Logarithmic Negativity, Rains Bound, Max-Rains Entropy, Logarithmic Negativity, PPT-relative metrics.
- Dynamic measures: Max Logarithmic Negativity, Max Rains Information.
- Capacity tools: quantum and entanglement-assisted capacities.

### Coherence Theory
- Robustness of coherence for states/channels.
- Channel simulation from resource states.

### Magic Theory
- Qubit: robustness-based and stabilizer-related tools.
- Qudit: mana and related non-stabilizer quantifiers.

### Quasi-Probability Error Mitigation
- Probabilistic error cancellation.
- Observable-dependent probabilistic/deterministic cancellation.
- Circuit knitting and virtual recovery.

### Supermap
- Quantum switch (Kraus and Choi forms).
- Link product and application utilities.

### Seesaw Algorithms
- CHSH game utilities.
- LOCC-oriented seesaw optimization helpers.

## Requirements
- MATLAB (desktop)
- QETLAB 0.9
- CVX 2.1
- Optional: `channel_magic` 2.0 for extended qubit-magic workflows

## Installation
1. Clone this repository.
2. Install QETLAB 0.9: https://qetlab.com/
3. Add QRLab and QETLAB to MATLAB path:
   ```matlab
   addpath(genpath('.../QETLAB-0.9'));
   addpath(genpath('.../QRLab'));
   savepath;
   ```
4. Install CVX 2.1: https://cvxr.com/cvx/
   ```matlab
   cd /path/to/cvx
   cvx_setup
   ```

## Quick Start
```matlab
rho = MaxEntangled(2) * MaxEntangled(2)';
ln_val = LogNeg(rho);
disp(ln_val);
```
A value close to `1` indicates the expected Bell-state behavior.

## Documentation
- API reference: https://quairkit.com/QRLab
- To inspect a function in MATLAB:
  ```matlab
  help LogNeg
  ```

## Productization and Compliance Notes
This repository includes a small, targeted compliance layer for software registration:
- Product scope and deliverables: `docs/PRODUCT_SPEC.md`
- Coding and maintenance rules: `docs/CODING_STANDARD.md`
- Auditable version history: `CHANGELOG.md` + `VERSION`

### Release Traceability Checklist
Before tagging a release:
1. Confirm dependency versions in `README.md`.
2. Update `VERSION`.
3. Add an entry to `CHANGELOG.md` with rationale and validation steps.
4. Verify docs-generation tooling if API-facing docs changed.

## Contributing
- Open issues for bugs and feature proposals.
- Keep PRs focused; avoid repository-wide cosmetic churn without technical value.
- Add or update tests/examples when behavior changes.

## Acknowledgements
This package was partially supported by the National Key R&D Program of China (Grant No. 2024YFE0102500).

We acknowledge CVXQUAD (https://github.com/hfawzi/cvxquad) for MATLAB-based convex optimization utilities used in related research.
