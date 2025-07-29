#!/bin/bash
#SBATCH --job-name=dask_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --time=1-06:00:00
#SBATCH --constraint=ntasks-per-node=1

source /home/znazari/.bashrc
conda activate Zainab-env
cd $SLURM_SUBMIT_DIR
python parallel_best_proteomic.py > parallel_result.txt
