#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=4

input_type=$1
processes=$2
array_size=$3
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=Quick-MPI-${input_type}-p${processes}-v${array_size}.cali, time.variance, topdown.toplevel)" \
mpirun -np $processes ./quick_mpi $input_type $array_size
squeue -j $SLURM_JOBID
