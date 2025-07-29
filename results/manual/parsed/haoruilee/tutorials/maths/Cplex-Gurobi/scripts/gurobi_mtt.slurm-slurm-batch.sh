#!/bin/bash
#SBATCH --job-name=Multi-threaded_gurobi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=01:00:00
#SBATCH --partition=batch
#SBATCH --qos=normal

module load math/Gurobi/8.1.1-intel-2018a-Python-3.6.4
MPS_FILE=$1
RES_FILE=$2
gurobi_cl Threads=${SLURM_CPUS_PER_TASK} ResultFile="${RES_FILE}.sol" ${MPS_FILE}
