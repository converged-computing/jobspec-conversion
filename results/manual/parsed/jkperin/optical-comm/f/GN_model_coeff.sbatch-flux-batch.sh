#!/bin/bash
#FLUX: --job-name=GN_coeff
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --priority=16

echo "SLURM_ARRAY_TASK_ID is " $SLURM_ARRAY_TASK_ID
module load matlab
srun matlab -nodesktop -singleCompThread -r "GN_model_coeff_slurm 50 $SLURM_ARRAY_TASK_ID"
