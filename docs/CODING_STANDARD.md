# QRLab Coding Standard

## 1. Scope
These rules apply to source code, tests, examples, and maintenance scripts in this repository.

## 2. MATLAB Code Rules
- Keep file names aligned with the primary function name.
- Validate critical inputs at function boundaries.
- Use explicit, actionable error messages for invalid dimensions/types.
- Keep CVX blocks readable and localized (`cvx_begin ... cvx_end`).
- Avoid no-op edits (such as mass header-only changes) unless required by an automated pipeline.

## 3. Documentation Rules
- `README.md` should reflect actual runtime dependencies and onboarding steps.
- New or behavior-changing features should include at least one usage example or test reference.
- Scripts under `docs/` must include clear invocation instructions.

## 4. Change Management
- Update `VERSION` and `CHANGELOG.md` together for each release.
- Describe validation commands in PR descriptions.
- Keep PR scope narrow and technically justified.

## 5. Validation Expectations
- Run syntax or smoke checks for modified scripts.
- For behavior changes, run relevant test files in `test_files/` where environment allows.
- If an environment limitation prevents execution (e.g., missing MATLAB), explicitly document it.
