#!/bin/bash
#FLUX: --job-name=persnickety-cinnamonbun-9395
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 128'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq//DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 128"
cd 001_prep_ideal_case 
rm -f OUT* OCE_IN_T0*
echo PREP_IDEAL_CASE${XYZ}
time $MPIRUN PREP_IDEAL_CASE${XYZ}
cd ../002_run1
rm -f OCE_IN_T0* OUT* pipe* PRESSURE GN_01*.*
ln -sf ../001_prep_ideal_case/OCE_IN_T0* .
echo MESONH${XYZ}
date
time $MPIRUN MESONH${XYZ}
cd ../003_spawn1
rm -f OUT* pipe* PRESSURE GN_01*.* 
ln -sf ../002_run1/GN_01*.* .
time $MPIRUN SPAWNING${XYZ}
cd ../004_run2
rm -f GN_01* OUT* pipe* PRESSURE SPWAN* 
ln -sf ../003_spawn1/GN_01.1.OC_01.002.spa00*.* .
ln -sf ../002_run1/GN_01* .
time $MPIRUN MESONH${XYZ}
cd ../005_python
ln -sf ../004_run2/SPWAN.*003.nc .
module purge
module load python/3.7.6
python3 plot_OCEAN.py
convert *.png OCEAN.pdf
