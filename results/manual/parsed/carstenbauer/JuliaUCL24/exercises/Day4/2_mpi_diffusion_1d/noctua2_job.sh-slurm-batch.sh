#!/bin/bash
#FLUX: --job-name=mpi_diffusion
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=600
#FLUX: --urgency=16

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
