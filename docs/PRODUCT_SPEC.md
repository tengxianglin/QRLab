# QRLab Product Specification

## 1. Product Positioning
QRLab is a MATLAB toolbox for research-grade analysis of quantum resources and quantum channels. It is intended for reproducible numerical studies and method prototyping.

## 2. Target Users
- Quantum information researchers
- Algorithm and error-mitigation engineers
- Graduate-level teaching and lab-maintenance teams

## 3. Functional Modules
- `Entanglement/`: static and dynamic entanglement measures and channel capacities
- `Coherence/`: coherence robustness and simulation workflows
- `Magic/`: qubit and qudit magic-resource quantification
- `QuasiTheory/`: error-cancellation and circuit-knitting utilities
- `Supermap/`: quantum-switch and link-product tools
- `seesaw/`: non-convex seesaw optimization helpers

## 4. Runtime Dependencies
- MATLAB desktop runtime
- QETLAB 0.9
- CVX 2.1
- Optional: `channel_magic` 2.0

## 5. Deliverables
- MATLAB source modules (`.m`)
- Precomputed data artifacts (`.mat`)
- Documentation and release metadata (`README.md`, `CHANGELOG.md`, `VERSION`, API script)

## 6. Release and Audit Policy
- Versioning follows `MAJOR.MINOR.PATCH`.
- Every functional/documentation release requires a changelog entry.
- Repository-wide cosmetic-only edits are discouraged unless justified by tooling or compliance requirements.
