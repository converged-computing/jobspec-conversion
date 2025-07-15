#!/bin/bash
#FLUX: --job-name="rfm_Gromacs_1400k_1_job"
#FLUX: -n=32
#FLUX: --exclusive
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_1:1'

module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_1:1
module load gromacs/2016.4-y5sjbs4
time \
srun gmx_mpi mdrun -s benchmark.tpr -g 1400k-atoms.log -noconfout
