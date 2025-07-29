#!/bin/bash
#SBATCH --job-name=BDD100K_preprocessing
#SBATCH --output=slurm-%j.out
#SBATCH --mail-user=neelgupta04@outlook.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-03:09:42
#SBATCH --partition=compute-od-gpu
#SBATCH --constraint=ntasks-per-node=1

export RAY_OBJECT_STORE_ALLOW_SLOW_STORAGE='0'
export JOBLIB_TEMP_FOLDER='/tmp'

CUDA_VISIBLE_DEVICES=-1 #no GPUs
TF_CPP_MIN_LOG_LEVEL=0 #logging
grep MemTotal /proc/meminfo
lscpu
nvidia-smi
export RAY_OBJECT_STORE_ALLOW_SLOW_STORAGE=0
export JOBLIB_TEMP_FOLDER=/tmp
pip3 install joblib psutil
singularity exec -B /fsx/awesome/temp/:/fsx/awesome/temp/ tfio_modified.sif python3 ./scripts/Final_converter.py
