#!/bin/bash
#SBATCH --job-name=glotzerlab-software build
#SBATCH --account=dmr140129
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=08:00:00
#SBATCH --partition=shared

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
