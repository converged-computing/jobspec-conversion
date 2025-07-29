#!/bin/bash
#SBATCH --job-name=modern-nn-potentials
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=00:30:00

source activate modern-nn-potentials
cd ~/projects/modern_nn_potentials/scripts
python ./posteriors_script.py
