#!/bin/bash
#FLUX: --job-name=doopy-bike-3806
#FLUX: --priority=16

export MPIRUN='Mpirun -np 1'

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
export MPIRUN="Mpirun -np 1"
set -x
set -e
ln -sf $MESONH/PGD/ECOCLIMAP_v2.0.* .
ln -sf $MESONH/PGD/srtm_ne_250.* .
ln -sf $MESONH/PGD/CLAY_HWSD_MOY.* .
ln -sf $MESONH/PGD/SAND_HWSD_MOY.* .
ls -lrt
rm -f PGD_CDG.???
time ${MPIRUN} PREP_PGD${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_pgd
touch PGD_CDG.des
ls -lrt
rm -f *.dir *.hdr
rm -f file_for_xtransfer pipe_name
sbatch run_prep_real_case
ja
