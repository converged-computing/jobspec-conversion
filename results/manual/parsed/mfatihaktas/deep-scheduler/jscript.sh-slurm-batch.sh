#!/bin/bash
#SBATCH --job-name=redsmall_plots_wDolly
#SBATCH --output=log/redsmall_plots_wDolly.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=12:00:00

export MV2_ENABLE_AFFINITY='0'

export MV2_ENABLE_AFFINITY=0
srun --mpi=pmi2 python3 /home/mfa51/deep-scheduler/redsmall_plots_wDolly.py --ro 
