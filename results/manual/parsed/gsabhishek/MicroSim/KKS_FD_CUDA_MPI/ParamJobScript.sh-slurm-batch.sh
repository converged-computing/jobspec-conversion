#!/bin/bash
#SBATCH --output=1450_slurm_NiAlMo
#SBATCH --nodes=4
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=2

module load gcc/10.2.0 cuda spack gnu8 gsl
. /home/apps/spack/share/spack/setup-env.sh
spack load nvhpc
mpirun -n $SLURM_NTASKS ./microsim_kks_fd_cuda_mpi Input.in Filling.in Output
