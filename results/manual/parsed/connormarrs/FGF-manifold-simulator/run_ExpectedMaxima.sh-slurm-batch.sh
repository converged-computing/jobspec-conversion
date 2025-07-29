#!/bin/bash
#SBATCH --mail-user=tyler.campos@yale.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=72
#SBATCH --cpus-per-task=1
#SBATCH --time=11:30:00
#SBATCH --partition=general
#SBATCH --exclude=cn[66-69,71-136,153-256,265-320,325-328]

module purge
module load gcc/9.2.0 libffi/3.2.1 bzip2/1.0.6 tcl/8.6.6.8606 sqlite/3.30.1 lzma/4.32.7 
module load python/3.9.2
python3 --version
pip install --user --upgrade pip
pip install --upgrade --user scipy
pip show scipy
python3 python_scripts/expected_means.py
