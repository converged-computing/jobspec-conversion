#!/bin/bash
#SBATCH --job-name=zhb
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=work
#SBATCH --constraint=ntasks-per-node=1

export I_MPI_FAVRICS='shm:dapl'
export OMP_NUM_THREADS='20         # 设置全局 OpenMP 线程为 20'

module load intel/18.0.1         # 添加 intelcompiler/18.0.0 模块
module load IMPI/2018.1.163-icc-18.0.1
export I_MPI_FAVRICS=shm:dapl
export OMP_NUM_THREADS=20         # 设置全局 OpenMP 线程为 20
valgrind --tool=massif --stacks=yes mpirun ./a.out
