#!/bin/bash
#SBATCH --job-name=CNN3
#SBATCH --account=stats
#SBATCH --mail-user=vljchr004@myuct.ac.za
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-22:00:00

module load python/anaconda-python-3.7
module load software/TensorFlow-CPU-py3
python -u /home/vljchr004/hpc-mini/model9.py > out_model9.txt
