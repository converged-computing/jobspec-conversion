#!/bin/bash
#FLUX: --job-name=prep_fanny
#FLUX: -t=2700
#FLUX: --urgency=16

export MPIRUN='Mpirun -np 1'

. /home/cnrm_other/ge/mrmh/rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ulimit -c 0
ulimit -s unlimited
set -e
hostname
set -x
set -e
ln -sf $MESONH/PGD/CLAY_HWSD_MOY.??? .
ln -sf $MESONH/PGD/SAND_HWSD_MOY.??? .
ln -sf $MESONH/PGD/gtopo30.??? .
ln -sf $MESONH/PGD/ECOCLIMAP_II_EUROP_V2.5.??? .
ln -sf $HOME/SAVE/CHIMIE_FILES/EMISSIONS/poet.an* .
ln -sf $HOME/SAVE/CHIMIE_FILES/EMISSIONS/poet*Aug* .
ln -sf $HOME/SAVE/CHIMIE_FILES/EMISSIONS/*so2* .
ln -sf $HOME/SAVE/CHIMIE_FILES/EMISSIONS/*nh3* .
rm -f ICARTT1008_PGD_15km.* OUTPUT_LISTING* pipe* *.tex
export MPIRUN="Mpirun -np 1"
time ${MPIRUN} PREP_PGD${XYZ}
cd ../002_pgd2/
sbatch run_prep_pgd2_xyz
