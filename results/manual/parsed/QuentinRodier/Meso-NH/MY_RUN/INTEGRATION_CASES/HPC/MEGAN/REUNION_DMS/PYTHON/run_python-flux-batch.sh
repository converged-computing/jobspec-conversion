#!/bin/bash
#FLUX: --job-name=gassy-train-5712
#FLUX: --urgency=16

ulimit -c 0
ulimit -s unlimited
set -e
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2-PIERRE
ln -sf ${SRC_MESONH}/src/LIB/Python/* .
module purge
module load python/3.7.6
python3 plot_MEGAN_REUNION.py
convert *.png MEGAN_REUNION.pdf
