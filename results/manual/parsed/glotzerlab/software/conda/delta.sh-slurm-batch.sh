#!/bin/bash
#SBATCH --job-name=glotzerlab-software build
#SBATCH --account=bbgw-delta-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=2000M
#SBATCH --time=08:00:00
#SBATCH --partition=cpu

export OUTPUT_FOLDER='/projects/bbgw/software/conda'

export OUTPUT_FOLDER=/projects/bbgw/software/conda
unset CMAKE_PREFIX_PATH
module reset
module load gcc/11.4.0 openmpi/4.1.6 cuda/12.3.0
./build.sh "$@" \
    --skip-existing \
    --variants "{'cluster': ['delta'], 'device': ['gpu'], 'gpu_platform': ['CUDA']}" \
    --output-folder $OUTPUT_FOLDER
chmod g-w $OUTPUT_FOLDER -R
chmod g+rX $OUTPUT_FOLDER -R
