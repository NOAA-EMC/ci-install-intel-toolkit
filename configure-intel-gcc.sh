#!/bin/bash
# Configure Intel compilers to use appropriate GCC version
# This script creates .cfg files for Intel compilers to ensure they use
# a compatible GCC version based on the Intel compiler version installed.

set -e

USE_CLASSIC=${1:?}
USE_ONEAPI=${2:?}
CLASSIC_VERSION=${3:?}
ONEAPI_VERSION=${4:?}

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

GCC_VERSION_CLASSIC=$(determine_gcc_version $CLASSIC_VERSION)
GCC_VERSION_ONEAPI=$(determine_gcc_version $ONEAPI_VERSION)

# Check if the GCC version is available, install if needed
#echo "Installing GCC ..."
#sudo apt-get update
#if [ $USE_CLASSIC ]; then
#  sudo apt-get install -y gcc-${GCC_VERSION_CLASSIC} g++-${GCC_VERSION_CLASSIC} gfortran-${GCC_VERSION_CLASSIC}
#fi
#if [ $USE_ONEAPI ]; then
#  sudo apt-get install -y gcc-${GCC_VERSION_ONEAPI} g++-${GCC_VERSION_ONEAPI} gfortran-${GCC_VERSION_ONEAPI}
#fi

  # Create/update icc.cfg
  icc_cfg_path=$(which icc).cfg
  echo "  Modifying icc.cfg with GCC ${GCC_VERSION_CLASSIC}:"
  echo "-gcc-name=gcc-${GCC_VERSION_CLASSIC}" | sudo tee $icc_cfg_path

  # Create/update icpc.cfg
  icpc_cfg_path=$(which icpc).cfg
  echo "  Modifying icpc.cfg with GCC ${GCC_VERSION_CLASSIC}:"
  echo "-gcc-name=gcc-${GCC_VERSION_CLASSIC} -gxx-name=g++-${GCC_VERSION_CLASSIC}" | sudo tee $icpc_cfg_path

  # Create/update ifort.cfg - also needs gcc specification for linking
  ifort_cfg_path=$(which ifort).cfg
  echo "  Modifying ifort.cfg with GCC ${GCC_VERSION_CLASSIC}:"
  echo "-gcc-name=gcc-${GCC_VERSION_CLASSIC}" | sudo tee $ifort_cfg_path

  echo "Intel compiler GCC configuration complete ($0)"

  # Create/update icx.cfg
  icx_cfg_path=$(which icx).cfg
  echo "  Modifying icx.cfg to use GCC ${GCC_VERSION_ONEAPI}:"
  echo "--gcc-toolchain=/usr/lib/gcc/x86_64-linux-gnu/${GCC_VERSION_ONEAPI}" | sudo tee $icx_cfg_path

  # Create/update icpx.cfg
  icpx_cfg_path=$(which icpx).cfg
  echo "  Modifying icpx.cfg to use GCC ${GCC_VERSION_ONEAPI}:"
  echo "--gcc-toolchain=/usr/lib/gcc/x86_64-linux-gnu/${GCC_VERSION_ONEAPI}" | sudo tee $icpx_cfg_path

  # Create/update ifx.cfg
  ifx_config_path=$(which ifx).cfg
  echo "  Modifying ifx.cfg to use GCC ${GCC_VERSION_ONEAPI}:"
  echo "-gcc-name=gcc-${GCC_VERSION_ONEAPI}" | sudo tee $ifx_config_path
