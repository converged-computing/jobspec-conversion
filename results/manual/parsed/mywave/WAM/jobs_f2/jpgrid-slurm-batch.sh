#!/bin/bash
#SBATCH --job-name=pgrid
#SBATCH --account=cluster
#SBATCH --output=wam.o%j
#SBATCH --error=wam.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=pCluster
#SBATCH --constraint=ntasks-per-node=1

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Coarse_Grid/JAN/Grid_User .
cp ${WAMDIR}/abs/pgrid pgrid.exe
./pgrid.exe
mv Grid_Prot ${WAMDIR}/dayfiles/coarse/pgrid_prot_coarse
rm Grid_User pgrid.exe
