#!/bin/bash
#SBATCH --job-name=Blaze
#SBATCH --output=zzout.eo%j
#SBATCH --error=zzout.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=05:20:00
#SBATCH --partition=normal256

export MPIRUN='Mpirun -np 128'

ulimit -c 0
ulimit -s unlimited
set -e
hostname
export MPIRUN="Mpirun -np 128"
set -x
set -e
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ../01_prep_ideal_case/PGDFireTest.* .
ln -sf ../01_prep_ideal_case/MNHFireTest.* .
time ${MPIRUN} MESONH${XYZ}
cd ../03_python
sbatch run_python
