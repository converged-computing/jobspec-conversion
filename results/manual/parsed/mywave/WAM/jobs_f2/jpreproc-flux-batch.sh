#!/bin/bash
#FLUX: --job-name=preproc
#FLUX: --queue=pCluster
#FLUX: -t=300
#FLUX: --priority=16

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
