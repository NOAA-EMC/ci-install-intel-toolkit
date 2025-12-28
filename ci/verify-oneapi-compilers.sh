#!/bin/bash
# Verify Intel oneAPI compilers are installed and configured correctly

set -e

# Expected FC compiler (defaults to ifx if not provided)
EXPECTED_FC=${1:-ifx}

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
test "$FC" = "$EXPECTED_FC" || { echo "ERROR: FC should be $EXPECTED_FC but is $FC"; exit 1; }

echo "✓ oneAPI compilers verified successfully (FC=$EXPECTED_FC)"
