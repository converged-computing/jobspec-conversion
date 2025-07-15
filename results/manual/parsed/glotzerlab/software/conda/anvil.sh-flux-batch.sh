#!/bin/bash
#FLUX: --job-name="glotzerlab-software build"
#FLUX: -c=32
#FLUX: --queue=shared
#FLUX: -t=28800
#FLUX: --priority=16

export OUTPUT_FOLDER='$PROJECT/software/conda'
export CC='$GCC_HOME/bin/gcc'
export CXX='$GCC_HOME/bin/g++'

export OUTPUT_FOLDER=$PROJECT/software/conda
unset CMAKE_PREFIX_PATH
module reset
module load gcc/11.2.0 openmpi/4.1.6
export CC=$GCC_HOME/bin/gcc
export CXX=$GCC_HOME/bin/g++
./build.sh "$@" \
    --skip-existing \
    --variants "{'cluster': ['anvil'], 'device': ['cpu'], 'gpu_platform': ['none']}" \
    --output-folder $OUTPUT_FOLDER
chmod g-w $OUTPUT_FOLDER -R
