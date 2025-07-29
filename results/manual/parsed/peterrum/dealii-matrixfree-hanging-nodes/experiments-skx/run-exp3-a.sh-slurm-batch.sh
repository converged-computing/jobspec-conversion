#!/bin/bash
#SBATCH --job-name=LIKWID
#SBATCH --account=pr83te
#SBATCH --output=run-exp3-a.out
#SBATCH --error=run-exp3-a.e
#SBATCH --mail-user=munch@lnm.mw.tum.de
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=48
#SBATCH --chdir=./
#SBATCH: --no-requeue

module unload intel-mpi/2019-intel
module unload intel/19.0.5
module load gcc/9
module load intel-mpi/2019-gcc
pwd
array=($(ls run-exp3-a-*.json))
mpirun -np  48 ./benchmark_01 json "${array[@]}" | tee exp3a_annulus.txt
array=($(ls run-exp3-b-*.json))
mpirun -np  48 ./benchmark_01 json "${array[@]}" | tee exp3a_quadrant.txt
