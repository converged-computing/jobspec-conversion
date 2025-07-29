#!/bin/bash
#SBATCH --job-name=matlab
#SBATCH --output=matlab_%a-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-46

module purge
module load matlab
args=`head -${SLURM_ARRAY_TASK_ID} numbers.txt | tail -1`
matlab -nojvm -nodisplay -nosplash -r "example(${args}),quit"
