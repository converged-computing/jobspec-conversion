#!/bin/bash
#FLUX: --job-name=crusty-egg-5624
#FLUX: --priority=16

module load pyger/0.9
conda init bash
conda activate rl
slurm_arr_idx=${SLURM_ARRAY_TASK_ID}
param_str=`python get_param_jobsub.py ${slurm_arr_idx}`
echo ${param_str}
srun python exp.py "${param_str}"
sacct --format="CPUTime,MaxRSS"
