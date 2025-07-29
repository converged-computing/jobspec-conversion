#!/bin/bash
#SBATCH --job-name=channel1D
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=4

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
echo "Submitting case $1"
cd run/$1
image="../../../of2106.sif"
bashrc="/usr/lib/openfoam/openfoam2106/etc/bashrc"
singularity exec $image bash -c "source $bashrc && ./Allrun_1D"
