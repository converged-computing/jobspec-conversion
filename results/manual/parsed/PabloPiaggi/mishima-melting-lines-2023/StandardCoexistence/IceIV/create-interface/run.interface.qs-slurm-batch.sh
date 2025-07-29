#!/bin/bash
#SBATCH --job-name=IV-interface
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --gres=gpu:4
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=4,ntasks-per-socket=2

module purge
module load rh/devtoolset/4
module load cudatoolkit/10.0
module load cudnn/cuda-10.0/7.6.3
module load openmpi/gcc/3.1.3/64
LAMMPS_EXE=/home/ppiaggi/Programs/Software-deepmd-kit-1.0/lammps-git2/src/lmp_mpi
source /home/ppiaggi/Programs/Software-deepmd-kit-1.0/tensorflow-venv/bin/activate
mpirun $LAMMPS_EXE -i in.lammps.create
