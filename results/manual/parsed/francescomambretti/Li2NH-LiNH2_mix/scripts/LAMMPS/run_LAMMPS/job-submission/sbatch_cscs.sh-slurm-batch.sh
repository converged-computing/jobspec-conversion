#!/bin/bash
#SBATCH --job-name=-gpu
#SBATCH --account=s1183
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=8,gpu

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export NO_STOP_MESSAGE='1'
export CRAY_CUDA_MPS='1 # to '

module load daint-gpu
module load LAMMPS/23Jun2022-CrayGNU-21.09-cuda
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NO_STOP_MESSAGE=1
export CRAY_CUDA_MPS=1 # to 
ulimit -s unlimited
echo "start MD..."
srun lmp_mpi -sf gpu -in in.lammps
