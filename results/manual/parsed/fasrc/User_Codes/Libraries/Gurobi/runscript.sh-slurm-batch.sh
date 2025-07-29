#!/bin/bash
#SBATCH --job-name=gurobitest
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:00:30

module load python
module load gurobi
source activate gurobi_env
srun -c $SLURM_CPUS_PER_TASK python gurobi_test.py
