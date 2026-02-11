# Changelog

All notable changes to this project are documented in this file.

The format is based on Keep a Changelog and the project follows Semantic Versioning.

## [Unreleased]
### Added
- Product documentation set: `docs/UserGuide.md`, `docs/DeveloperGuide.md`, `docs/SoftwareDescription.md`, and `docs/RefactorReport.md`.
- Runnable examples in `examples/` for utility and entanglement dispatcher workflows.
- `matlab.unittest` smoke tests in `tests/` and a top-level test runner `runtests_qrlab.m`.
- GitHub Actions workflow for MATLAB test execution using MathWorks official setup action.

### Changed
- Improved input validation, diagnostics, and maintainability in selected core functions:
  - `Coherence/FlagPoleState.m`
  - `utils/KetBra.m`
  - `Supermap/LinkProd.m`
  - `Entanglement/compute_entanglement_measures.m`

## [0.1.0]
### Added
- Initial public release baseline.
