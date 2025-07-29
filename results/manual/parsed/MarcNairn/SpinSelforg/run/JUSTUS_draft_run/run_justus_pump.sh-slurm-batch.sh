#!/bin/bash
#SBATCH --job-name=pump_range_Nmc
#SBATCH --output=pump_range_Nmc-%j.out
#SBATCH --error=pump_range_Nmc-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-999

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export MKL_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export HOME='~'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export MKL_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export HOME=~
srun julia run/JUSTUS_draft_run/run_parallel_justus_pump.jl ${SLURM_ARRAY_TASK_ID}
