#!/bin/bash
#SBATCH --job-name=array-example
#SBATCH --output=log-array-example-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=00:10:00

module load julia/1.2.0
echo "Slurm Job ID, unique: $SLURM_JOB_ID"
echo "Slurm Array Task ID, relative: $SLURM_ARRAY_TASK_ID"
julia array_example.jl $1 $SLURM_JOB_ID $SLURM_ARRAY_TASK_ID
mv log-array-example-${SLURM_JOB_ID}.out $1/log-array-example-${SLURM_JOB_ID}.out
