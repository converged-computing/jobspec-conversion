#!/bin/bash
#SBATCH --job-name=amrex_quokka
#SBATCH --account=ast146
#SBATCH --output=1node_%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=8

export FI_MR_CACHE_MAX_COUNT='0  # libfabric disable caching'
export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_OFI_NIC_POLICY='NUMA'

export FI_MR_CACHE_MAX_COUNT=0  # libfabric disable caching
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_OFI_NIC_POLICY=NUMA
srun build/src/HydroBlast3D/test_hydro3d_blast tests/benchmark_unigrid_512.in
