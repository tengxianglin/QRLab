# Changelog

All notable changes to this project are documented in this file.

The format is based on Keep a Changelog and follows Semantic Versioning.

## [Unreleased]

### Added
- Product documentation set: user guide, developer guide, software description, and refactor report.
- New `examples/` scripts for basic utilities and configurable measure dispatch.
- New `tests/` suite based on `matlab.unittest`.
- Test entrypoint script `runtests_qrlab.m`.
- GitHub Actions workflow for MATLAB test execution.

### Changed
- Refined core public functions (`KetBra`, `CQMI`, `LinkProd`, `QSwitch`, `LogNeg`, `compute_entanglement_measures`) with stronger input validation and clearer error handling.
- Reworked `README.md` into an English-only product-oriented guide.

## [0.1.0] - Initial baseline

### Added
- Initial public release of QRLab quantum resource theory toolbox.
