#!/bin/bash
#SBATCH --output=logs/step2_%a.out
#SBATCH --error=logs/step2_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=00:20:00
#SBATCH --partition=all

echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
echo "Array Allocation Number: $SLURM_ARRAY_JOB_ID"
echo "Array Index: $SLURM_ARRAY_TASK_ID"
module load anacondapy/2020.11
module load elastix/4.8
. activate brainpipe
xvfb-run -d python main.py 2 ${SLURM_ARRAY_TASK_ID} #combine stacks into single tifffiles
