#!/bin/bash
# Verify that Intel compilers are NOT already installed

set -e

echo "=== Verifying Intel compilers are not pre-installed ==="

FOUND_COMPILER=0

# Check for Classic compilers
if command -v icc &> /dev/null; then
    echo "ERROR: icc is already installed at $(which icc)"
    FOUND_COMPILER=1
fi

if command -v icpc &> /dev/null; then
    echo "ERROR: icpc is already installed at $(which icpc)"
    FOUND_COMPILER=1
fi

if command -v ifort &> /dev/null; then
    echo "ERROR: ifort is already installed at $(which ifort)"
    FOUND_COMPILER=1
fi

# Check for oneAPI compilers
if command -v icx &> /dev/null; then
    echo "ERROR: icx is already installed at $(which icx)"
    FOUND_COMPILER=1
fi

if command -v icpx &> /dev/null; then
    echo "ERROR: icpx is already installed at $(which icpx)"
    FOUND_COMPILER=1
fi

if command -v ifx &> /dev/null; then
    echo "ERROR: ifx is already installed at $(which ifx)"
    FOUND_COMPILER=1
fi

if [ $FOUND_COMPILER -eq 1 ]; then
    echo "FAILED: Intel compilers should not be pre-installed"
    exit 1
fi

echo "✓ Verified: No Intel compilers are pre-installed"
