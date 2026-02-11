# Developer Guide

## Architecture

QRLab is organized by domain folders:

- `Entanglement/`
- `Coherence/`
- `Magic/`
- `QuasiTheory/`
- `Supermap/`
- `utils/`

### Design principles used in current refactor

- Public functions should include MATLAB H1 help text and runnable examples.
- Input validation should use `arguments` blocks where practical.
- Error messages should include project-scoped identifiers (for example `QRLab:Component:Issue`).
- Backward compatibility should be preserved unless a safe deprecation warning path is provided.

## Coding conventions

- Prefer `fullfile` for path construction.
- Avoid hard-coded absolute paths.
- Use deterministic behavior in tests.
- Keep examples lightweight and dependency-aware.

## Testing

Run all tests:

```matlab
runtests_qrlab
```

Run a subset:

```matlab
results = runtests('tests');
disp(table(results));
```

## Adding new modules

1. Create functions in the appropriate domain folder.
2. Add help text and validation.
3. Add at least one example script in `examples/`.
4. Add/update tests in `tests/`.
5. Document new behavior in `CHANGELOG.md` under `Unreleased`.

## Quality checklist

Before submitting changes:

- [ ] Public functions include help text, syntax, inputs/outputs, and examples.
- [ ] Inputs are validated and error identifiers are descriptive.
- [ ] No hard-coded machine-specific paths are introduced.
- [ ] Tests pass locally (or have clear skip reasons for missing toolboxes/dependencies).
- [ ] `CHANGELOG.md` updated.
