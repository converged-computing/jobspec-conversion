#!/bin/bash
#SBATCH --mail-user=$USER@adelaide.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --time=01:00:00

pip install -U datetime pandas numpy warnings numba seaborn matplotlib tqdm
swig -c++ -python LCSFinder.i 
python setup.py build_ext --inplace
python testing_p.py
