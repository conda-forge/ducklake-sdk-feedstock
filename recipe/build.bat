@echo on

set CARGO_PROFILE_RELEASE_STRIP=symbols
set CARGO_PROFILE_RELEASE_LTO=fat

:: Remove this wrapper once https://github.com/conda-forge/rust-activation-feedstock/pull/79 is merged
copy "%RECIPE_DIR%\cargo-auditable-wrapper.bat" "%BUILD_PREFIX%\bin\cargo-auditable-wrapper.bat" || exit 1
set CARGO=cargo-auditable-wrapper

:: Bundle licenses
cargo-bundle-licenses --format yaml --output "%SRC_DIR%\THIRDPARTY.yml" || exit 1

:: Build
python -m pip install . ^
    --no-deps --ignore-installed -vv --no-build-isolation --disable-pip-version-check
