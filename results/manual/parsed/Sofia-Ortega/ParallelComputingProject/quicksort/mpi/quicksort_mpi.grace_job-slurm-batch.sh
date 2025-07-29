#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=40
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:03:00
#SBATCH --constraint=ntasks-per-node=32

array_size=$1
processes=$2
option=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=p${processes}-a${array_size}-o${option}.cali, \
  time.variance)" \
mpirun -np $processes ./quicksort_mpi $array_size $option
