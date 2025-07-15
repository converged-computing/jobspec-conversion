#!/bin/bash
#FLUX: --job-name=dirty-taco-5472
#FLUX: --priority=16

ulimit -c 0
ulimit -s unlimited
set -e
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ${SRC_MESONH}/src/LIB/Python/* .
module purge
module load python/3.7.6
python3 plot_FIRE_LEFR.py
convert *.png FIRE_LEFR.pdf
python3 plot_FIRE_RKC4.py
convert *.png FIRE_RKC4.pdf
python3 plot_FIRE_RKC4_LIMA_ECRAD.py
convert *.png FIRE_RKC4_LIMA_ECRAD.pdf
python3 plot_FIRE_WENO5.py
convert *.png FIRE_WENO5.pdf
