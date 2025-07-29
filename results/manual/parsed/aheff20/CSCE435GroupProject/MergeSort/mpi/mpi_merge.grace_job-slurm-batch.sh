#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=32

array_size=$1
processes=$2
type=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=cali_recent_2/p${processes}-a${array_size}-t${type}.cali, \
    time.variance)" \
mpirun -np $processes ./merge_mpi $array_size $type
