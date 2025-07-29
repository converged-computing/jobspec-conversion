#!/bin/bash
#SBATCH --job-name=rfm_LaghosTest0_branson_0_82__arm___nodes___1___mpi___64___omp___1__job
#SBATCH --output=rfm_LaghosTest0_branson_0_82__arm___nodes___1___mpi___64___omp___1__job.out
#SBATCH --error=rfm_LaghosTest0_branson_0_82__arm___nodes___1___mpi___64___omp___1__job.err
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=64

export OMP_NUM_THREADS='1'
export OMP_PLACES='cores'

spack load branson@0.82 %arm
export OMP_NUM_THREADS=1
export OMP_PLACES=cores
cp /home/iman/rfms/branson/proxy_small.xml ./branson.in
srun BRANSON ./branson.in > branson.out
