#!/bin/bash
#SBATCH --job-name=LIKWID
#SBATCH --account=pr83te
#SBATCH --output=run-exp4-b.out
#SBATCH --error=run-exp4-b.e
#SBATCH --mail-user=munch@lnm.mw.tum.de
#SBATCH --mail-type=END
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=./
#SBATCH --no-requeue

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
mpirun -np 768 ./benchmark_02 quadrant 9 4 0 1 | tee exp4_b_0_1.txt
mpirun -np 768 ./benchmark_02 quadrant 9 4 1 0 | tee exp4_b_1_0.txt
mpirun -np 768 ./benchmark_02 quadrant 9 4 0 0 | tee exp4_b_0_0.txt
