#!/bin/bash
#SBATCH --job-name=dask_control
#SBATCH --account=some_account
#SBATCH --output=log_dask_control-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2-00:00:00

module load python
python run_psweep.py
