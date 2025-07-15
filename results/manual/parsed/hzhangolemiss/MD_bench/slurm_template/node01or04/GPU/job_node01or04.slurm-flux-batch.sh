#!/bin/bash
#FLUX: --job-name=xxx
#FLUX: -t=2592000
#FLUX: --priority=16

export CUDA_MPS_PIPE_DIRECTORY='$SLURM_SUBMIT_DIR/nvidia-mps.$SLURM_JOB_ID'
export CUDA_MPS_LOG_DIRECTORY='$SLURM_SUBMIT_DIR/nvidia-log.$SLURM_JOB_ID'

cd $SLURM_SUBMIT_DIR
module load openmpi
module load openblas
module load fftw3
module load lammps/gcc/sfft/openmpi/cuda/2Aug23.3
export CUDA_MPS_PIPE_DIRECTORY=$SLURM_SUBMIT_DIR/nvidia-mps.$SLURM_JOB_ID
export CUDA_MPS_LOG_DIRECTORY=$SLURM_SUBMIT_DIR/nvidia-log.$SLURM_JOB_ID
nvidia-cuda-mps-control -d
sleep 1
mpiexec --bind-to core --map-by core -n 12 lmp_mpi -sf gpu -pk gpu 2 neigh yes newton on pair/only off split 1.0 -i input.lmps
sleep 1
echo quit | nvidia-cuda-mps-control
sleep 1
rm -r $SLURM_SUBMIT_DIR/nvidia-*
module purge
