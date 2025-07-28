#!/bin/bash
#FLUX: --job-name=CUDA_Run_base_2
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cmake cuda boost python
cd build_cuda_2
python ../run_base.py $SLURM_ARRAY_TASK_ID
