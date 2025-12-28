# GitHub CI Action: install-intel-toolkit

![Test action](https://github.com/NOAA-EMC/ci-install-intel-toolkit/actions/workflows/test-action.yml/badge.svg)

This repository provides a GitHub Action for download and caching the Intel
Classic and oneAPI compilers for Linux, as well as OpenMP, MPI, and MKL.

This repository supports [NCEPLIBS](https://github.com/NOAA-EMC/NCEPLIBS) CI
workflows.

To submit bug reports, feature requests, or other code-related issues including
usage questions, please create a [GitHub
issue](https://github.com/NOAA-EMC/ci-install-intel-toolkit/issues). For general
NCEPLIBS inquiries, contact [Ed Hartnett](mailto:edward.hartnett@noaa.gov)
(secondary point of contact [Alex Richert](mailto:alexander.richert@noaa.gov)).

### Authors

[Alex Richert](mailto:alexander.richert@noaa.gov)

### Usage

To use this Action, include the following step in your GitHub Actions workflow:
```
      - name: "Install Intel compilers & MPI"
        uses: NOAA-EMC/ci-install-intel-toolkit@develop
        with:
          install-mpi: true
```

The current default version is 2023.2.1, which supports both Classic and oneAPI.

See `action.yml` for the full list of available options and their defaults.

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
