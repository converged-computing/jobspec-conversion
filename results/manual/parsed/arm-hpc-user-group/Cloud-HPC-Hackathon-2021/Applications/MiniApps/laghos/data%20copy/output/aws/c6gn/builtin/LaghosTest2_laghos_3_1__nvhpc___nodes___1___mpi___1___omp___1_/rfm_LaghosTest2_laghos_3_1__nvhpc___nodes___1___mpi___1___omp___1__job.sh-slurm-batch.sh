#!/bin/bash
#SBATCH --job-name=rfm_LaghosTest2_laghos_3_1__nvhpc___nodes___1___mpi___1___omp___1__job
#SBATCH --output=rfm_LaghosTest2_laghos_3_1__nvhpc___nodes___1___mpi___1___omp___1__job.out
#SBATCH --error=rfm_LaghosTest2_laghos_3_1__nvhpc___nodes___1___mpi___1___omp___1__job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=c6gn
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load laghos@3.1 %nvhpc
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
srun laghos -p 1 -dim 2 -rs 3 -tf 0.8 -pa > laghos.out
