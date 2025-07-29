#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=stats
#SBATCH --mail-user=vljchr004@myuct.ac.za
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

module load software/TensorFlow-CPU-py3 
module load python/TensorAnaconda
module load software/R-3.5.1
module load python/anaconda-python-3.7 
Rscript /home/vljchr004/myscript.R /scratch/vljchr004/x_265377 /scratch/vljchr004/y_265377
