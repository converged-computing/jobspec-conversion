#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --constraint=ntasks-per-node=32

input_type=$1
processes=$2
input_size=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=SS-MPI-i${input_type}-p${processes}-s${input_size}.cali, \
    time.variance)" \
mpirun -np $processes ../../../Sample_Sort $input_type $processes $input_size
