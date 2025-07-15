#!/bin/bash
#FLUX: --job-name=hoomd
#FLUX: --queue=GPU-shared
#FLUX: -t=1800
#FLUX: --priority=16

echo "testing lj-npt on one gpu"
T=1.3
singularity exec --nv /ocean/projects/see220002p/shared/icomse_gpu.sif python lj-npt.py $SLURM_JOB_ID $T
