#!/bin/bash
# Verify Intel Classic compilers are installed and configured correctly

set -e

echo "=== Checking Classic Compilers ==="
which icc
which icpc
which ifort
icc --version
icpc --version
ifort --version

echo "=== Checking Environment Variables ==="
echo "CC=$CC"
echo "CXX=$CXX"
echo "FC=$FC"

test "$CC" = "icc" || { echo "ERROR: CC should be icc but is $CC"; exit 1; }
test "$CXX" = "icpc" || { echo "ERROR: CXX should be icpc but is $CXX"; exit 1; }
test "$FC" = "ifort" || { echo "ERROR: FC should be ifort but is $FC"; exit 1; }

echo "✓ Classic compilers verified successfully"
