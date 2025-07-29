#!/bin/bash
#SBATCH --job-name=test_julia
#SBATCH --account=snic2022-22-368
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=64

srun julia mpi_experiment.jl > /cfs/klemming/home/e/emilwa/Private/slurm_output12.txt 2> /cfs/klemming/home/e/emilwa/Private/slurm_stderr12.txt
