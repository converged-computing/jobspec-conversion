#!/bin/bash
#SBATCH --job-name=ptime
#SBATCH --account=cluster
#SBATCH --output=ptime.o%j
#SBATCH --error=ptime.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set -k
WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/Coarse_Grid/JAN/Time_User .
cp ${WAMDIR}/abs/ptime ptime.exe
./ptime.exe
mv Time_Prot ${WAMDIR}/dayfiles/ptime_prot_coarse_JAN
rm Time_User ptime.exe 
