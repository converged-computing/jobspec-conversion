#!/bin/bash
#SBATCH --job-name=prefetch
#SBATCH --output=job.%N.%j.out
#SBATCH --error=job.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

module purge
module load userspace/custom opt/all userspace/all
module load cmake/3.22.2
module load intel-compiler/64/2018.3.222
module load intel-mkl/64/2018.3.222
module load intel-mpi/64/2018.3.222
module load intel-mpi/64/2018.3.222
make all
