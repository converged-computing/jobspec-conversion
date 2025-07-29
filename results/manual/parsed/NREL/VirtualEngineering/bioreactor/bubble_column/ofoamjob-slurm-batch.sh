#!/bin/bash
#SBATCH --job-name=bcolumn
#SBATCH --account=vebio
#SBATCH --output=log.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=36

module purge
module load openmpi/1.10.7/gcc-7.3.0
module load gcc
source /projects/vebio/hsitaram/VirtualEngineering/submodules/OpenFOAM-dev/etc/bashrc
. ./presteps.sh
srun -n 72 reactingTwoPhaseEulerFoam -parallel
