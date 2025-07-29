#!/bin/bash
#SBATCH --job-name=PYTHON
#SBATCH --account=<r2-user-name>
#SBATCH --output=outputs/results.o%j
#SBATCH --error=outputs/errors.e%j
#SBATCH --mail-user=<your-email-id>
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpuq

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 1000
module load cuda10.0/toolkit/10.0.130 # loading cuda libraries/drivers 
module load python/intel/3.7          # loading python environment
python3 train_cnn_script.py
