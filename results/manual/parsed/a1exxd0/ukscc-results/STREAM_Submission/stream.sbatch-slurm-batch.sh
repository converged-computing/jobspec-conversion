#!/bin/bash
#SBATCH --job-name=stream4
#SBATCH --output=build/stream_final.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='16'
export OMP_PROC_BIND='spread'

module load compilers/armclang/24.04
module load libraries/openmpi/5.0.3/armclang-24.04
export OMP_NUM_THREADS=16
export OMP_PROC_BIND=spread
srun -n 1 ./STREAM/stream
