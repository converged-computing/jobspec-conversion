#!/bin/bash
#FLUX: --job-name=carnivorous-carrot-7074
#FLUX: --urgency=16

ulimit -c 0
ulimit -s unlimited
set -e
hostname 
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2
ln -sf ~rodierq/MNHPy/src/* .
module purge
module load python/3.7.6
python3 plot_MNH_PREP.py
convert *.png MNH_PREP_ARP.pdf
