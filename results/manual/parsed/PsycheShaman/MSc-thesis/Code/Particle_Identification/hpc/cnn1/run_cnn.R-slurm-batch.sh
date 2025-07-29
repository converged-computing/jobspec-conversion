#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=stats
#SBATCH --mail-user=vljchr004@myuct.ac.za
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=ada

module load software/R-3.5.2
module load python/anaconda-python-3.7 
module load software/TensorFlow-CPU-py3
module load python/TensorAnaconda 
Rscript cnn.R /scratch/vljchr00/data/train
