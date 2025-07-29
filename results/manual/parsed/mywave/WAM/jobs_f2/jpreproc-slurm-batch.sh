#!/bin/bash
#SBATCH --job-name=preproc
#SBATCH --account=cluster
#SBATCH --output=preproc.o%j
#SBATCH --error=preproc.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=pCluster
#SBATCH --constraint=ntasks-per-node=1

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set +k
WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WORK}/work/Grid_info_COARSE_GRID .
cp ${WAMDIR}/const/TOPOCAT.DAT .
cp ${WAMDIR}/const/Fine_2/JAN/Preproc_User .
cp ${WAMDIR}/abs/preproc preproc.exe
srun ./preproc.exe
mv Preproc_Prot ${WAMDIR}/dayfiles/preproc_prot_fine_2
mv Grid_info_fine_2_GRID ../work
rm Preproc_User preproc.exe TOPOCAT.DAT Grid_info_COARSE_GRID
