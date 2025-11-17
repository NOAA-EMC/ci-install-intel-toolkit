#!/bin/bash
# Verify that Intel compilers are configured to use the correct GCC version

set -e

echo "=== Checking Intel Compiler GCC Configuration ==="

# Function to extract GCC version from compiler output
check_compiler_gcc() {
    local compiler=$1
    local compiler_name=$2
    
    if ! command -v $compiler &> /dev/null; then
        echo "Skipping $compiler_name (not installed)"
        return
    fi
    
    echo "Checking $compiler_name..."
    
    # For oneAPI compilers (icx, icpx, ifx) - they show GCC info with --version
    if [[ "$compiler" == "icx" ]] || [[ "$compiler" == "icpx" ]] || [[ "$compiler" == "ifx" ]]; then
        $compiler --version
        # Check if cfg file exists
        cfg_file=$(dirname $(which $compiler))/${compiler}.cfg
        if [ -f "$cfg_file" ]; then
            echo "  Config file found: $cfg_file"
            cat "$cfg_file"
        else
            echo "  Warning: No config file found at $cfg_file"
        fi
    # For classic compilers (icc, icpc, ifort)
    elif [[ "$compiler" == "icc" ]] || [[ "$compiler" == "icpc" ]] || [[ "$compiler" == "ifort" ]]; then
        $compiler --version
        # Check if cfg file exists
        cfg_file=$(dirname $(which $compiler))/${compiler}.cfg
        if [ -f "$cfg_file" ]; then
            echo "  Config file found: $cfg_file"
            cat "$cfg_file"
        else
            echo "  Warning: No config file found at $cfg_file"
        fi
    fi
    
    echo ""
}

# Check all Intel compilers
check_compiler_gcc "icc" "Intel Classic C Compiler"
check_compiler_gcc "icpc" "Intel Classic C++ Compiler"
check_compiler_gcc "ifort" "Intel Classic Fortran Compiler"
check_compiler_gcc "icx" "Intel oneAPI C Compiler"
check_compiler_gcc "icpx" "Intel oneAPI C++ Compiler"
check_compiler_gcc "ifx" "Intel oneAPI Fortran Compiler"

echo "✓ Compiler GCC configuration check complete"
