#!/bin/bash
#FLUX: --job-name=OpenMP_Run_base
#FLUX: -c=40
#FLUX: --exclusive
#FLUX: --queue=intel_32
#FLUX: -t=25200
#FLUX: --urgency=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cmake boost python
cd build_omp
python ../run_base.py $SLURM_ARRAY_TASK_ID
