#!/bin/bash
#SBATCH --account=rda-goesstf
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

date
cd /scratch1/RDARCH/rda-goesstf/conus2/Code
MYPY=/scratch1/RDARCH/rda-goesstf/anaconda/bin/python
srun -n $SLURM_NTASKS $MYPY MAIN_TRAIN_and_SAVE_MODEL.py $1
date
