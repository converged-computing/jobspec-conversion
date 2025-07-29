#!/bin/bash
#SBATCH --job-name=heraus-test1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=23:00:00

unset SLURM_EXPORT_ENV
module load python/3.8-anaconda
module load cuda
source activate base
python nnOOD_run_training.py fullres nnOODTrainerDS heraus_png FPI 1
