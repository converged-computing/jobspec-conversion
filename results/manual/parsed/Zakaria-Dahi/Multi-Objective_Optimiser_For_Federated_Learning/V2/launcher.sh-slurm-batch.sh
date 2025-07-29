#!/bin/bash
#SBATCH --job-name=thefinal_optfl_dense
#SBATCH --output=./logs/array_%A_%a.out
#SBATCH --error=./logs/array_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=400G
#SBATCH --array=1

export SLURM_CPU_BIND='none'

date
hostname
export SLURM_CPU_BIND=none
HOSTFILE=$(pwd)/hostfile
source $(pwd)/../optfl_env/bin/activate
EOF
source $(pwd)/../optfl_env/bin/activate
scontrol show hostnames > $HOSTFILE
INPUTFILE=$(pwd)/src/nsga2.py 
python -m scoop --hostfile $HOSTFILE -n 100 $INPUTFILE $SLURM_ARRAY_TASK_ID "DENSE" 4 $@
