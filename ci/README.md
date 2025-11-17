# CI Test Files

This directory contains helper scripts and test source code used by the GitHub Actions workflow in `.github/workflows/test-action.yml`.

## Verification Scripts

- **verify-no-intel-compilers.sh** - Verifies that Intel compilers (icc, icpc, ifort, icx, icpx, ifx) are NOT pre-installed on the runner
- **verify-classic-compilers.sh** - Verifies Intel Classic compilers (icc, icpc, ifort) are installed and environment variables are set correctly
- **verify-oneapi-compilers.sh** - Verifies Intel oneAPI compilers (icx, icpx, ifx) are installed and environment variables are set correctly
- **verify-mpi.sh** - Verifies Intel MPI is installed and wrappers are configured correctly (takes `oneapi` or `classic` as argument)
- **verify-gcc-config.sh** - Verifies Intel compilers have GCC configuration files (.cfg) and displays their contents

## Test Source Files

### Basic Compilation Tests
- **hello.c** - Simple C "Hello World" program
- **hello.cpp** - Simple C++ "Hello World" program
- **hello.f90** - Simple Fortran "Hello World" program

### MPI Tests
- **mpi_hello.c** - MPI C program that prints from each rank
- **mpi_hello.f90** - MPI Fortran program that prints from each rank

### OpenMP Tests
- **openmp_test.c** - OpenMP C program with parallel region
- **openmp_test.f90** - OpenMP Fortran program with parallel region

### MKL Tests
- **mkl_test.c** - MKL C program that performs BLAS dgemm operation
- **mkl_test.f90** - MKL Fortran program that performs BLAS dgemm operation

### Combined Tests
- **combined_test.c** - Program combining MPI, OpenMP, and MKL features

## Usage

These files are automatically used by the GitHub Actions workflow. They help keep the workflow YAML file clean and maintainable by separating test logic and source code from workflow configuration.
