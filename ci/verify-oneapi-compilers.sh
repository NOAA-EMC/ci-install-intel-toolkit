#!/bin/bash
# Verify Intel oneAPI compilers are installed and configured correctly

set -e

echo "=== Checking oneAPI Compilers ==="
which icx
which icpx
which ifx
icx --version
icpx --version
ifx --version

echo "=== Checking Environment Variables ==="
echo "CC=$CC"
echo "CXX=$CXX"
echo "FC=$FC"

test "$CC" = "icx" || { echo "ERROR: CC should be icx but is $CC"; exit 1; }
test "$CXX" = "icpx" || { echo "ERROR: CXX should be icpx but is $CXX"; exit 1; }
test "$FC" = "ifx" || { echo "ERROR: FC should be ifx but is $FC"; exit 1; }

echo "✓ oneAPI compilers verified successfully"
