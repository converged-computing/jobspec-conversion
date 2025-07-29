#!/bin/bash
#SBATCH --job-name=testFarm
#SBATCH --output=testFarm-log-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00
#SBATCH --partition=Brody

module load julia/1.2.0
echo "Slurm Job ID, unique: $SLURM_JOB_ID"
echo "Slurm Array Task ID, relative: $SLURM_ARRAY_TASK_ID"
arg1=$1
arg2=$2
shift
shift
sumofargs=$((arg1 + arg2))
echo "sum of args is $sumofargs"
echo "other args are $@"
