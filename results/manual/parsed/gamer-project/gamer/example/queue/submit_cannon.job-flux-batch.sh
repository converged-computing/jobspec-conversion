#!/bin/bash
#FLUX: --job-name=hanky-frito-1860
#FLUX: -n=2
#FLUX: -c=4
#FLUX: --queue=itc_gpu
#FLUX: -t=190
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export MPI_TYPE_MAX='655360'
export MPI_TYPE_DEPTH='32'
export MPI_MSGS_MAX='10485760'
export MPI_BUFS_PER_PROC='256'
export MPI_BUFS_PER_HOST='512'
export MPI_USE_CUDA='1'
export MPI_DSM_DISTRIBUTE='0'
export KMP_AFFINITY='disabled'
export HDF5_DISABLE_VERSION_CHECK='1'

export OMP_NUM_THREADS=4
module load gcc/12.2.0-fasrc01
module load mpich
module load hdf5
module load cuda
export CUDA_VISIBLE_DEVICES=0,1,2,3
export MPI_TYPE_MAX=655360
export MPI_TYPE_DEPTH=32
export MPI_MSGS_MAX=10485760
export MPI_BUFS_PER_PROC=256
export MPI_BUFS_PER_HOST=512
export MPI_USE_CUDA=1
export MPI_DSM_DISTRIBUTE=0
export KMP_AFFINITY=disabled
export HDF5_DISABLE_VERSION_CHECK=1
srun -n $SLURM_NTASKS --cpus-per-task=4 --mpi=pmix ./gamer
