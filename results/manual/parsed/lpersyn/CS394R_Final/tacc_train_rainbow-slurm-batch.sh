#!/bin/bash
#SBATCH --job-name=train_rainbow
#SBATCH --account=IRI24006
#SBATCH --output=train_rainbow.o%j
#SBATCH --error=train_rainbow.e%j
#SBATCH --mail-user=logan.persyn@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --partition=gpu-a100

source /work/09320/lpersyn/ls6/anaconda3/etc/profile.d/conda.sh
conda activate ../cs394-work-env
python ./tianshou/atari_rainbow.py --logdir $SCRATCH/cs394R/final_project_logs/     # Do not use ibrun or any other MPI launcher
