#!/bin/bash
#SBATCH --job-name=static_pump_Nmc
#SBATCH --output=static_pump_Nmc-%a_%A.out
#SBATCH --error=static_pump_Nmc-%a_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --constraint=ntasks-per-node=1

srun julia run/JUSTUS_draft_run/run_parallel_justus_static.jl $SLURM_ARRAY_TASK_ID $1 $2 $3 $4
