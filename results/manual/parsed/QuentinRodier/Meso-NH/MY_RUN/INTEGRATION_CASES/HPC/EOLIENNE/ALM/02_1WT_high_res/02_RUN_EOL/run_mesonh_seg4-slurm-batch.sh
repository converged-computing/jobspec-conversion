#!/bin/bash
#SBATCH --job-name=ALM2_024
#SBATCH --output=ideal_fire.eo%j
#SBATCH --error=ideal_fire.eo%j
#SBATCH --nodes=32
#SBATCH --ntasks=2048
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

export MPIRUN='Mpirun -np 2048'

ulimit -c 0
ulimit -s unlimited
set -e
hostname
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 2048"
set -x
set -e
cp EXSEG1.nam_SEG4 EXSEG1.nam
time ${MPIRUN} MESONH${XYZ}
rm -f file_for_xtransfer pipe_name
mv OUTPUT_LISTING0 OUTPUT_LISTING0_SEG4
mv OUTPUT_LISTING1 OUTPUT_LISTING1_SEG4
sbatch run_python
