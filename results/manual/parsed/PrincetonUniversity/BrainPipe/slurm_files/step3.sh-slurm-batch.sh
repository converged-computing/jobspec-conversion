#!/bin/bash
#SBATCH --output=logs/step3_%a.out
#SBATCH --error=logs/step3_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=11:40:00

module load anacondapy/2020.11
module load elastix/4.8
. activate brainpipe
xvfb-run python main.py 3 ${SLURM_ARRAY_TASK_ID} #run elastix; -d flag is NECESSARY for depth coding
