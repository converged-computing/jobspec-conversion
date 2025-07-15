#!/bin/bash
#FLUX: --job-name=blbfit
#FLUX: --priority=16

module load pymods/2.7
module load numpy
srun python BLB_lin_reg_job.py -i ${SLURM_ARRAYID}
