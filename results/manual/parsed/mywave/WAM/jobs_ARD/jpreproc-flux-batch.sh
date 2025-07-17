#!/bin/bash
#FLUX: --job-name=preproc
#FLUX: --queue=pCluster
#FLUX: -t=300
#FLUX: --urgency=16

module load compilers/intel/2019.4.243
module load intelmpi/2019.4.243
module load netcdf
set +k
WAMDIR=/gpfs/home/behrens/WAM_Cycle_6
WORK=/gpfs/work/behrens/WAM_Cycle_6
cd ${WORK}/tempsg
cp ${WAMDIR}/const/TOPOCAT.DAT .
cp ${WAMDIR}/const/Coarse_Grid/ARD/Preproc_User .
cp ${WAMDIR}/abs/preproc preproc.exe
srun ./preproc.exe
mv Preproc_Prot ${WAMDIR}/dayfiles/preproc_prot_coarse_ARD
mv Grid_info_COARSE_GRID ../work
rm Preproc_User preproc.exe TOPOCAT.DAT
