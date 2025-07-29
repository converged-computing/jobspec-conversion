#!/bin/bash
#SBATCH --job-name=vakEV
#SBATCH --account=PAA0202
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=serial
#SBATCH --constraint=ntasks-per-node=1

cd $SLURM_SUBMIT_DIR
module load gnu/9.1.0
module load openmpi/1.10.7
module load mkl/2019.0.5
module load R/4.0.2
module load miniconda3
source activate vak-env
conda activate vak-env; sh ~/bioacoustics/TOMLS/EV/run_tweetynet_empidonax_1train_slurm.job
