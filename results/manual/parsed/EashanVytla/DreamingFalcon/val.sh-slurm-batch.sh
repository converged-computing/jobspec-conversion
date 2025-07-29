#!/bin/bash
#SBATCH --job-name=DreamerTraining_Prelim
#SBATCH --account=PAS2152
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=28

cd $SLURM_SUBMIT_DIR
module load miniconda3/23.3.1-py310  cuda/12.3.0
source activate pytorch
python3 valid_dynamics.py
python3 test_dynamics.py
