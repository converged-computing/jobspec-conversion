#!/bin/bash
#SBATCH --job-name=echo
#SBATCH --account=<yourProject>
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=test

module purge
module load slurm_setup
module load spack/23
module load intel-toolkit
source ../LRZoneAPI.sh # Takes care of modules
./dpecho_gpu
exit
