#!/bin/bash
#SBATCH --job-name=c600-eq
#SBATCH --nodes=3
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=7
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
pwd; hostname; date
module purge
module load rh/devtoolset/4
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
LAMMPS_EXE=/home/ppiaggi/Programs/Software-deepmd-kit-1.0/lammps-git2/src/lmp_mpi
source /home/ppiaggi/Programs/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
mpirun -np $SLURM_NTASKS $LAMMPS_EXE -sf omp -in start.lmp
