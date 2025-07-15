#!/bin/bash
#FLUX: --job-name=job1_re
#FLUX: -t=7200
#FLUX: --priority=16

module purge
module load mathematica/12.1.1
module load python/intel/3.8.6
cd run${SLURM_ARRAY_TASK_ID}
srun math < rerun.m > rerun.out
