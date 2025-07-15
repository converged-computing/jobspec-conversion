#!/bin/bash
#FLUX: --job-name=OpenMP_Run_multiple
#FLUX: -c=40
#FLUX: --exclusive
#FLUX: --queue=intel_32
#FLUX: -t=14400
#FLUX: --priority=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cmake boost python
cd build_omp
python ../run_multiple_detectors.py $SLURM_ARRAY_TASK_ID
