# Changelog

All notable changes to QRLab are documented in this file.

## [0.2.1] - 2026-02-11
### Changed
- Reworked productization updates to be targeted and technically meaningful rather than repository-wide cosmetic edits.
- Removed blanket header-only insertions from MATLAB source files.
- Rewrote `README.md` into a concise, English-only product and release guide.
- Refined `docs/PRODUCT_SPEC.md` and `docs/CODING_STANDARD.md` with enforceable maintenance policies.
- Fixed `docs/api/update_RTM_rst.py:is_correct_directory()` path validation logic.

### Validation
- Python syntax check for API docs script completed successfully.
- Verified no MATLAB files retain the prior mass-inserted productization header.

## [0.2.0] - 2026-02-11
### Added
- Added repository-level productization documentation:
  - `docs/PRODUCT_SPEC.md`
  - `docs/CODING_STANDARD.md`
  - `CHANGELOG.md`

### Changed
- Added productization sections to `README.md`.
- Updated `VERSION` from `0.1.0` to `0.2.0`.
- Updated API maintenance helper script documentation header.
