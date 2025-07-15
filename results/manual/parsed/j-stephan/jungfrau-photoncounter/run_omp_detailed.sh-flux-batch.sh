#!/bin/bash
#FLUX: --job-name=OpenMP_Run_detailed
#FLUX: -c=40
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: -t=28800
#FLUX: --urgency=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cmake boost python
cd build_omp
python ../run_detailed.py $SLURM_ARRAY_TASK_ID
