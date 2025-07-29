#!/bin/bash
#SBATCH --job-name=xxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=30-00:00:00
#SBATCH --constraint=ntasks-per-node=8,ntasks-per-socket=8

cd $SLURM_SUBMIT_DIR
mpiexec --bind-to core --map-by core -n 8 lmp_2Aug2023_update3_more_gcc_sfft_openmpi_cuda_mps -i input.lmps
