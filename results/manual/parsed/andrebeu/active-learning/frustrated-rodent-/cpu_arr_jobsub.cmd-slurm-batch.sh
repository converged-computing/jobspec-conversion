#!/bin/bash
#SBATCH --output=./slurms/output.%j.%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=03:59:00

module load pyger/0.9
conda init bash
conda activate rl
slurm_arr_idx=${SLURM_ARRAY_TASK_ID}
param_str=`python get_param_jobsub.py ${slurm_arr_idx}`
echo ${param_str}
srun python exp.py "${param_str}"
sacct --format="CPUTime,MaxRSS"
