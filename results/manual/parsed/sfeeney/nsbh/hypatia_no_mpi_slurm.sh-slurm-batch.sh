#!/bin/bash
#SBATCH --job-name=nsbh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=CORES24
#SBATCH: --exclusive
#SBATCH --array=1-24

module purge
source /share/apps/anaconda/3-2019.03/etc/profile.d/conda.sh
conda activate condagw3
module load rocks-openmpi_ib
time python sim_nsbh_analysis.py $SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_ID
