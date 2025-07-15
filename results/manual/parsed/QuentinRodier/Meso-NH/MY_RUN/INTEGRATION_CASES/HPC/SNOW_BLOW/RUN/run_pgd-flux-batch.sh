#!/bin/bash
#FLUX: --job-name=gloopy-nalgas-5171
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 1'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 1"
set -x
set -e
ln -sf $HOME/SAVE/GRIB_KTEST/mntclb_llv.txt . 
ls -lrt
rm -f  CLB_PGD_50m* OUTPUT_* pipe* *.tex
time ${MPIRUN} PREP_PGD${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_pgd
rm -f file_for_xtransfer pipe_name
sbatch run_prep_ideal_case
ja
