#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=32

processes=$1
array_size=$2
option=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=outputs/perturbed/p${processes}/bitonic_mpi_p${processes}-a${array_size}_${option}.cali, \
    time.variance)" \
mpirun -np $processes ./bitonic_mpi $array_size $option
