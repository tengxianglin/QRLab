# QRLab Software Description

## Product Summary
QRLab is a MATLAB toolbox for research and education in quantum information processing and quantum resource theory. The package provides optimization-based and analytical routines for evaluating resource measures and simulating resource-aware transformations.

## Functional Modules

### Entanglement Module
- Static entanglement quantifiers (for example logarithmic negativity and Rains-type bounds).
- Dynamic/channel-oriented measures and capacity-related routines.
- Dispatcher utility (`compute_entanglement_measures`) for multi-measure batch evaluation.

### Coherence Module
- Coherence robustness computations.
- Coherence-relevant state constructors and simulation helpers.

### Magic Module
- Qubit and qudit magic resource measures.
- Representative state constructors and support data for stabilizer-related workflows.

### Quasi-Theory Module
- Probabilistic and observable-dependent error cancellation.
- Decomposition and virtual recovery routines for mitigation pipelines.

### Supermap Module
- Quantum switch implementations (Kraus and Choi representations).
- Link product construction for channel composition in Choi form.

### Utilities
- Foundational linear-algebra primitives and helper routines used across modules.

## Technical Characteristics
- **Language**: MATLAB
- **External dependencies**: QETLAB 0.9, CVX 2.1 (module-dependent)
- **Design style**: functional MATLAB scripts/functions organized by resource-theory domain

## Intended Use
- Algorithm prototyping in quantum information science.
- Reproducible numerical experiments in resource theory.
- Classroom/lab demonstrations of convex optimization and channel/state measures.

## Reliability and Maintainability Measures
- Input validation and standardized diagnostics in core utility paths.
- Reproducible examples under `examples/`.
- Automated smoke tests with `matlab.unittest` in `tests/` and unified runner `runtests_qrlab.m`.
