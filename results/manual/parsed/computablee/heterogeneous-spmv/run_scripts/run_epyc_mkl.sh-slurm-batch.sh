#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=RM

cp -r $PROJECT/matrices $RAMDISK
module load intel/20.4
python3 run_epyc_mkl.py $RAMDISK
