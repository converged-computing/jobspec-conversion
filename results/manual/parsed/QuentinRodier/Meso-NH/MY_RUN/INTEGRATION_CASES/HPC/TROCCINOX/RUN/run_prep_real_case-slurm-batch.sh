#!/bin/bash
#SBATCH --job-name=prep_troc
#SBATCH --output=prep_troc.eo%j
#SBATCH --error=prep_troc.eo%j
#SBATCH --nodes=2
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

export MPIRUN='Mpirun -np 64'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq//DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 64"
set -x
set -e
ln -sf $HOME/SAVE/GRIB_KTEST/ecmwf.OD.2005020* .
ls -lrt
rm -f TROC_050204.00.???
cp PRE_REAL1.nam_1 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep1
ls -lrt
rm -f TROC_050204.06.???
cp PRE_REAL1.nam_2 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep2
ls -lrt
rm -f TROC_050204.12.???
cp PRE_REAL1.nam_3 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep3
ls -lrt
rm -f TROC_050204.18.???
cp PRE_REAL1.nam_4 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep4
ls -lrt
rm -f TROC_050205.00.???
cp PRE_REAL1.nam_5 PRE_REAL1.nam
time ${MPIRUN} PREP_REAL_CASE${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_prep5
ls -lrt
rm -f PRE_REAL1.nam
rm -f file_for_xtransfer pipe_name
sbatch run_mesonh
ja
