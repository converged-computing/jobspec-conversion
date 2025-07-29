#!/bin/bash
#SBATCH --job-name=echo
#SBATCH --output=screen/echo_%a.log
#SBATCH --mail-user=cecile.ane@wisc.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --array=0-9

echo "slurm task ID = $SLURM_ARRAY_TASK_ID"
echo "today is $(date)" > output/echo_$SLURM_ARRAY_TASK_ID.out
