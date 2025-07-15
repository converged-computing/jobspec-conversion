#!/bin/bash
#FLUX: --job-name=compile_cleo
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --priority=16

cleoenv=$1        # get from command line argument
buildtype=$2      # get from command line argument
path2build=$3     # get from command line argument
executables="$4"  # get from command line argument
spack load cmake@3.23.1%gcc
module load gcc/11.2.0-gcc-11.2.0
source activate ${cleoenv}
if [[ "${buildtype}" == "cuda" ]]
then
  module load nvhpc/23.9-gcc-11.2.0
fi
if [[ "${buildtype}" == "" ||
      "${path2build}" == "" ||
      "${executables}" == "" ]]
then
  echo "Bad inputs, please check your buildtype, path2build and executables"
else
  ### ---------------- compile executables --------------- ###
  echo "path to build directory: ${path2build}"
  echo "executables: ${executables}"
  cd ${path2build}
  make -j 128 ${executables}
  ### ---------------------------------------------------- ###
fi
