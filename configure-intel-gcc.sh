#!/bin/bash
# Configure Intel compilers to use appropriate GCC version
# This script creates .cfg files for Intel compilers to ensure they use
# a compatible GCC version based on the Intel compiler version installed.

set -e

INSTALL_CLASSIC="${1:-false}"
INSTALL_ONEAPI="${2:-false}"
CLASSIC_VERSION="${3:-}"
ONEAPI_VERSION="${4:-}"

# Determine appropriate GCC version based on Intel compiler version
# Intel 2023.x series supports GCC up to 12.x
# Intel 2024.0.x supports GCC up to 13.x
# Intel 2024.1+ supports GCC up to 14.x
determine_gcc_version() {
  local intel_version=$1
  local major=$(echo $intel_version | cut -d. -f1)
  local minor=$(echo $intel_version | cut -d. -f2)
  
  if [ "$major" = "2023" ]; then
    echo "12"
  elif [ "$major" = "2024" ]; then
    if [ "$minor" = "0" ]; then
      echo "13"
    else
      echo "14"
    fi
  else
    # Default to GCC 13 for unknown versions
    echo "13"
  fi
}

# Find the installed compiler directories
ONEAPI_ROOT="/opt/intel/oneapi/compiler"

if [ "$INSTALL_CLASSIC" = "true" ] || [ "$INSTALL_ONEAPI" = "true" ]; then
  # Determine GCC version to use
  if [ "$INSTALL_ONEAPI" = "true" ]; then
    GCC_VERSION=$(determine_gcc_version "$ONEAPI_VERSION")
  else
    GCC_VERSION=$(determine_gcc_version "$CLASSIC_VERSION")
  fi
  
  echo "Configuring Intel compilers to use GCC-${GCC_VERSION}"
  
  # Check if the GCC version is available, install if needed
  if ! command -v gcc-${GCC_VERSION} &> /dev/null; then
    echo "Installing GCC-${GCC_VERSION}..."
    sudo apt-get update
    sudo apt-get install -y gcc-${GCC_VERSION} g++-${GCC_VERSION} gfortran-${GCC_VERSION}
  fi
  
  # Find the actual compiler installation paths
  if [ -d "$ONEAPI_ROOT" ]; then
    for version_dir in $(find $ONEAPI_ROOT -maxdepth 1 -type d -name "20*" 2>/dev/null); do
      echo "Configuring compilers in $version_dir"
      
      # Configure oneAPI compilers (icx, icpx, ifx)
      if [ "$INSTALL_ONEAPI" = "true" ]; then
        if [ -d "$version_dir/bin" ]; then
          # Create/update icx.cfg
          if [ -f "$version_dir/bin/icx" ]; then
            echo "--gcc-toolchain=/usr/lib/gcc/x86_64-linux-gnu/${GCC_VERSION}" | sudo tee "$version_dir/bin/icx.cfg" > /dev/null
            echo "  Created icx.cfg with GCC ${GCC_VERSION}"
          fi
          
          # Create/update icpx.cfg
          if [ -f "$version_dir/bin/icpx" ]; then
            echo "--gcc-toolchain=/usr/lib/gcc/x86_64-linux-gnu/${GCC_VERSION}" | sudo tee "$version_dir/bin/icpx.cfg" > /dev/null
            echo "  Created icpx.cfg with GCC ${GCC_VERSION}"
          fi
          
          # Create/update ifx.cfg
          if [ -f "$version_dir/bin/ifx" ]; then
            echo "-gcc-name=gcc-${GCC_VERSION}" | sudo tee "$version_dir/bin/ifx.cfg" > /dev/null
            echo "  Created ifx.cfg with GCC ${GCC_VERSION}"
          fi
        fi
      fi
      
      # Configure Classic compilers (icc, icpc, ifort) - use -gcc-name flag
      if [ "$INSTALL_CLASSIC" = "true" ]; then
        if [ -d "$version_dir/bin/intel64" ]; then
          # Create/update icc.cfg
          if [ -f "$version_dir/bin/intel64/icc" ]; then
            echo "-gcc-name=gcc-${GCC_VERSION}" | sudo tee "$version_dir/bin/intel64/icc.cfg" > /dev/null
            echo "  Created icc.cfg with GCC-${GCC_VERSION}"
          fi
          
          # Create/update icpc.cfg
          if [ -f "$version_dir/bin/intel64/icpc" ]; then
            echo "-gxx-name=g++-${GCC_VERSION}" | sudo tee "$version_dir/bin/intel64/icpc.cfg" > /dev/null
            echo "  Created icpc.cfg with G++-${GCC_VERSION}"
          fi
          
          # Create/update ifort.cfg - also needs gcc specification for linking
          if [ -f "$version_dir/bin/intel64/ifort" ]; then
            echo "-gcc-name=gcc-${GCC_VERSION}" | sudo tee "$version_dir/bin/intel64/ifort.cfg" > /dev/null
            echo "  Created ifort.cfg with GCC-${GCC_VERSION}"
          fi
        fi
      fi
    done
  fi
  
  echo "Intel compiler GCC configuration complete"
else
  echo "No Intel compilers to configure"
fi
