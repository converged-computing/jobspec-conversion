#!/bin/bash
#SBATCH --job-name=strong-scaling-1node
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-user=yakup.paradox@gmail.com
#SBATCH --mail-type=end,fail,timeout
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:20:00
#SBATCH --constraint=ntasks-per-node=28
#SBATCH --chdir=./
#SBATCH --no-requeue

module load slurm_setup
module unload intel-mpi/2019-intel
module unload intel-oneapi-compilers/2021.4.0
module unload intel-mkl/2020
module load cmake
module load gcc/11
module load petsc/3.17.2-gcc11-ompi-real
module load openmpi/4.1.2-gcc11
mpirun -n 28 ${HOME}/ns-eof/build/NS-EOF-Runner \
    ${HOME}/runs/Cavity2D-1node.xml
