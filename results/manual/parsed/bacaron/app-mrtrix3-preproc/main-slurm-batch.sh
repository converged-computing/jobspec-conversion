#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

export SINGULARITYENV_OMP_NUM_THREADS='$OMP_NUM_THREADS'

set -x
set -e
export SINGULARITYENV_OMP_NUM_THREADS=$OMP_NUM_THREADS
time singularity exec -e --nv docker://brainlife/mrtrix3:3.0.0 ./mrtrix3_preproc.sh
