#!/bin/bash
#SBATCH --job-name=celltracking
#SBATCH --account=m1867
#SBATCH --output=log_celltracking.log
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=haswell

date
conda activate /global/common/software/m1867/python/flextrkr
cd /global/homes/f/feng045/program/PyFLEXTRKR
python ./runscripts/run_celltracking.py ./config/config_csapr500m_example.yml
date
