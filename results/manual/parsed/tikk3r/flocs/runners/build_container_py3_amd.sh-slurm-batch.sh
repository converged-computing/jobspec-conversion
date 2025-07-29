#!/bin/bash
#SBATCH --job-name=build_container
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=03:00:00
#SBATCH --constraint=amd

singularity build --fakeroot --force lofar_sksp_v4.0.2_znver2_znver2_noavx512_aocl_cuda_ddf.sif Singularity.amd_aocl
