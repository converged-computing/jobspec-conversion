#!/bin/bash
#SBATCH --job-name=solve_MIP
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=4-04:00:00

  # Standard output and error log (%j expands to jobId)
module load StdEnv/2023
module load gurobi/11.0.1
source /home/mehdii/projects/def-vidalthi/mehdii/3DPU_Plateau_Problem/env_gurobi_HZ/bin/activate
pip install gurobipy
echo "Threads ${SLURM_CPUS_ON_NODE:-1}" > gurobi.env   # set number of threads
python /home/mehdii/projects/def-vidalthi/mehdii/3DPU_Plateau_Problem/Plateau_Problem/Triangulation_Meshing/tests/test_MIP.py
