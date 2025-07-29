#!/bin/bash
#SBATCH --job-name=diag_fanny
#SBATCH --output=diag_fanny.eo%j
#SBATCH --error=diag_fanny.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export MPIRUN='Mpirun -np 128'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 128"
set -x
set -e
ls -lrt
time ${MPIRUN} DIAG${XYZ}
