#!/bin/bash
#SBATCH --job-name=log_log
#SBATCH --account=phys025062
#SBATCH --output=scramble_out.txt
#SBATCH --error=scramble_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000M
#SBATCH --time=2-00:00:00
#SBATCH --partition=QuamNESS
#SBATCH --constraint=ntasks-per-node=28

module purge
module load lang/julia/1.8.5
cd "${SLURM_SUBMIT_DIR}"
echo "Running on host $(hostname)"
echo "Started on $(date)"
echo "Directory is $(pwd)"
echo "Slurm job ID is ${SLURM_JOBID}"
echo "This jobs runs on the following machines:"
echo "${SLURM_JOB_NODELIST}" 
printf "\n\n"
julia MF_ising.jl 150.0 201 
printf "\n\n"
echo "Ended on: $(date)"
