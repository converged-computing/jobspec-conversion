#!/bin/bash
#SBATCH --job-name=pgd_kclb
#SBATCH --output=pgd_kclb.eo%j
#SBATCH --error=pgd_kclb.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

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
