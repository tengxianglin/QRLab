# QRLab Developer Guide

## Repository Layout
- `Entanglement/`, `Coherence/`, `Magic/`, `QuasiTheory/`, `Supermap/`, `seesaw/`: core algorithm modules.
- `utils/`: shared utility functions.
- `examples/`: lightweight runnable scripts.
- `tests/`: `matlab.unittest`-based tests.
- `docs/`: user and developer documentation.

## Coding Conventions
- Add MATLAB H1 help text for all public functions.
- Prefer explicit input validation (`validateattributes` for broad compatibility).
- Use namespaced identifiers for diagnostics (for example `QRLab:Module:Issue`).
- Keep APIs backward-compatible unless a change is necessary; document behavior changes in `CHANGELOG.md`.
- Use `fullfile` and relative path discovery over hard-coded machine-specific paths.

## Testing
Run the full suite:
```matlab
results = runtests_qrlab;
```

Run one test class:
```matlab
results = runtests('tests/TestCoreUtilities.m');
```

## Adding a New Module
1. Place function files in an existing module folder or a new top-level folder.
2. Add complete help text and examples for any public entrypoint.
3. Add smoke tests under `tests/`.
4. Update `docs/SoftwareDescription.md` and `CHANGELOG.md`.

## Quality Checklist
Before opening a PR, verify:
- [ ] Function help text is complete and accurate.
- [ ] Inputs are validated with clear error messages.
- [ ] Warnings/errors include stable identifiers.
- [ ] Tests added or updated for changed behavior.
- [ ] Examples run without manual edits.
- [ ] `runtests_qrlab` executes with clear pass/skip status.
- [ ] Changelog entry is included.

## CI Notes
A GitHub Actions workflow (`.github/workflows/matlab-tests.yml`) is provided to run tests using MathWorks' official MATLAB action. It requires repository-level MATLAB CI configuration (license/secrets) to execute in forks.
