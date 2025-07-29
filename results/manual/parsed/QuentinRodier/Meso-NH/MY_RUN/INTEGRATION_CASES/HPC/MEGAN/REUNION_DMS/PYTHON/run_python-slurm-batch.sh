#!/bin/bash
#SBATCH --job-name=tools
#SBATCH --output=tools.eo%j
#SBATCH --error=tools.eo%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

ulimit -c 0
ulimit -s unlimited
set -e
. ~rodierq/DEV_57/MNH-PHYEX070-b95d84d7/conf/profile_mesonh-LXifort-R8I4-MNH-V5-6-2-ECRAD140-MPIAUTO-O2-PIERRE
ln -sf ${SRC_MESONH}/src/LIB/Python/* .
module purge
module load python/3.7.6
python3 plot_MEGAN_REUNION.py
convert *.png MEGAN_REUNION.pdf
