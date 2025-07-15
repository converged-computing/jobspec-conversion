#!/bin/bash
#FLUX: --job-name=frigid-despacito-7941
#FLUX: --priority=16

ulimit -c 0
ulimit -s unlimited
set -e
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ${SRC_MESONH}/src/LIB/Python/* .
ln -sf ~rodierq/SAVE/OUTILS/PYTHON/departements-20180101.* .
ln -sf ../007_run/AZF02.*.CEN4T.*.nc .
module purge
module load python/3.7.6
python3 plot_AZF2M.py
convert *.png AZF_2M.pdf
