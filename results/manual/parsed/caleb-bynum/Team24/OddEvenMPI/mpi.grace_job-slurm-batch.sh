#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:30:00

array_size=$1
processes=$2
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=p${processes}-a${array_size}.cali, \
    time.variance)" \
mpirun -np $processes ./OddEvenSort $array_size
