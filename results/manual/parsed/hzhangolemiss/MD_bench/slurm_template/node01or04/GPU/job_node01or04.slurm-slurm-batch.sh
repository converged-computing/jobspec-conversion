#!/bin/bash
#SBATCH --job-name=xxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=200M
#SBATCH --time=30-00:00:00
#SBATCH --constraint=ntasks-per-node=12,ntasks-per-socket=12

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
