#!/bin/bash
#SBATCH --output=robust_linear_regression/output2Huber.out
#SBATCH --error=robust_linear_regression/error2Huber.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=120G
#SBATCH --time=1-00:00:00
#SBATCH --partition=parallel
#SBATCH --chdir=/home/troiani/

module load gcc
module load mvapich2
module load python
source venv/updated-venv/bin/activate
cd robust_linear_regression
srun python optimal_experiments_Huber_decorrerlated_2.py
deactivate
