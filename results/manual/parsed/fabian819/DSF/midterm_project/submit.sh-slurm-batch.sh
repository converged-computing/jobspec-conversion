#!/bin/bash
#SBATCH --job-name=Midterm Project
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=00:30:00

module purge
module load Python
pip install --user rdkit scikit-learn tensorflow numpy pandas matplotlib
srun python3 ./DSF/midterm.py
