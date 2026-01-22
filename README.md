# GitHub CI Action: install-intel-toolkit

![Test action](https://github.com/NOAA-EMC/ci-install-intel-toolkit/actions/workflows/test-action.yml/badge.svg)

This repository provides a GitHub Action for downloading and caching the Intel
Classic and oneAPI compilers for Linux, as well as OpenMP, MPI, and MKL. It is
only intended to work with Ubuntu runners.

This repository supports [NCEPLIBS](https://github.com/NOAA-EMC/NCEPLIBS) CI
workflows.

To submit bug reports, feature requests, or other code-related issues including
usage questions, please create a [GitHub
issue](https://github.com/NOAA-EMC/ci-install-intel-toolkit/issues). For general
NCEPLIBS inquiries, contact [Alex Richert](mailto:alexander.richert@noaa.gov)
(secondary point of contact [Hang Lei](mailto:hang.lei@noaa.gov)).

## Authors

[Alex Richert](mailto:alexander.richert@noaa.gov)

## Usage

To use this Action, include the following step in your GitHub Actions workflow:
```
      - name: "Install Intel compilers & MPI"
        uses: NOAA-EMC/ci-install-intel-toolkit@develop
        with:
          install-mpi: true
          mpi-wrapper-setup: oneapi
```

<!-- action-docs-inputs source="action.yml" -->
### Inputs

| name | description | required | default |
| --- | --- | --- | --- |
| `install-classic` | <p>Install Intel Classic compilers (icc/icpc/ifort)</p> | `false` | `true` |
| `classic-version` | <p>Set Intel Classic version</p> | `false` | `2023.2.1` |
| `install-oneapi` | <p>Install Intel oneAPI compilers (icx/icpx/ifx)</p> | `false` | `true` |
| `oneapi-version` | <p>Set Intel oneAPI version</p> | `false` | `2025.3` |
| `install-mpi` | <p>Install Intel MPI libraries</p> | `false` | `false` |
| `mpi-version` | <p>Set Intel MPI version</p> | `false` | `2021.10.0` |
| `mpi-wrapper-setup` | <p>Choose compilers for MPI wrappers (options: classic, oneapi, none)</p> | `false` | `none` |
| `install-openmp` | <p>Install Intel OpenMP libraries</p> | `false` | `false` |
| `openmp-version` | <p>Set Intel OpenMP library version</p> | `false` | `2023.2.1` |
| `install-mkl` | <p>Install Intel MKL</p> | `false` | `false` |
| `mkl-version` | <p>Set Intel MKL version</p> | `false` | `2023.2.0` |
| `env-update` | <p>Apply environment modifications to $GITHUB_ENV</p> | `false` | `true` |
| `cache` | <p>Cache to repository cache with actions/cache</p> | `false` | `true` |
| `shell` | <p>Which shell to use/setup</p> | `false` | `bash` |
| `compiler-setup` | <p>Set CC, CXX, FC as part of environment setup ("env-update"); choose "oneapi" or "classic"</p> | `false` | `""` |
| `oneapi-fortran-compiler` | <p>Set FC to ifx or ifort for oneAPI compilers (options: ifx, ifort; ifort only available 2023.x &amp; 2024.x)</p> | `false` | `ifx` |
| `force-cache-save` | <p>Save cache as long as toolkit installation is successful (i.e., do not wait for whole workflow to finish)</p> | `false` | `true` |
<!-- action-docs-inputs source="action.yml" -->

## Disclaimer

The United States Department of Commerce (DOC) GitHub project code is provided
on an "as is" basis and the user assumes responsibility for its use. DOC has
relinquished control of the information and no longer has responsibility to
protect the integrity, confidentiality, or availability of the information. Any
claims against the Department of Commerce stemming from the use of its GitHub
project will be governed by all applicable Federal law. Any reference to
specific commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their endorsement,
recommendation or favoring by the Department of Commerce. The Department of
Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used
in any manner to imply endorsement of any commercial product or activity by DOC
or the United States Government.
