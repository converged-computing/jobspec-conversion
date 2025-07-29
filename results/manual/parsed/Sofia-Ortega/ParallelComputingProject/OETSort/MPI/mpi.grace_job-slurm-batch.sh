#!/bin/bash
#SBATCH --job-name=JobName
#SBATCH --output=output.%j
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=4

processes=$1
values=$2
module load intel/2020b       # load Intel software stack
module load CMake/3.12.1
CALI_CONFIG="spot(output=caliper-${values}.cali)" \
mpirun -np $processes ./oetsort $values
squeue -j $SLURM_JOBID
