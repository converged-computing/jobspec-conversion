#!/bin/bash
#SBATCH --job-name=blazor
#SBATCH --mail-user=ashutiwa@iu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=22
#SBATCH --mem=64gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=dl
#SBATCH --constraint=ntasks-per-node=1,ntasks-per-node=1

conda deactivate
module load deeplearning/2.8.0
srun python driver.py & python driver_multilabel.py
