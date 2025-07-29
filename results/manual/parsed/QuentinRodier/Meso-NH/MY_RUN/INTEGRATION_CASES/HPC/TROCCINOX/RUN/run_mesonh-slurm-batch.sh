#!/bin/bash
#SBATCH --job-name=run_troc
#SBATCH --output=run_troc.eo%j
#SBATCH --error=run_troc.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

export MPIRUN='Mpirun -np 128'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq//DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 128"
set -x
set -e
rm -f TROCC.1.CEN4T.*
ls -lrt
echo "================== EXSEG1.nam============="
cat EXSEG1.nam
echo "=========================================="
echo "=========================================="
echo "=========================================="
time ${MPIRUN} MESONH${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_run
mv OUTPUT_LISTING1  OUTPUT_LISTING1_run
echo "=========================================="
ls -lrt TROCC.1.CEN4T*
echo "=========================================="
sbatch run_diag
ja
