#!/bin/bash
#SBATCH --job-name=mpi_diffusion
#SBATCH --account=hpc-lco-usrtr
#SBATCH --output=mpi_diffusion_job-%A.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=5

export JULIA_DEPOT_PATH=':/scratch/hpc-lco-usrtr/.julia_ucl'
export SLURM_EXPORT_ENV='ALL'

ml r
ml lang/JuliaHPC/1.10.0-foss-2022a-CUDA-11.7.0
export JULIA_DEPOT_PATH=:/scratch/hpc-lco-usrtr/.julia_ucl
export SLURM_EXPORT_ENV=ALL
echo -e "Blocking communication"
mpiexecjl --project -n 10 julia diffusion_1d.jl
echo -e "\n\nNon-blocking communication (overlapping with computation)"
mpiexecjl --project -n 10 julia diffusion_1d_hidecomm.jl
