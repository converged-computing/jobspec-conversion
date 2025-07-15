#!/bin/bash
#FLUX: --job-name=bricky-diablo-4634
#FLUX: -N=2
#FLUX: -n=49
#FLUX: -t=3600
#FLUX: --urgency=16

export CP2K_DATA_DIR='/home/ongari/aiida-database/data/cp2k/data '

source /ssoft/spack/bin/slmodules.sh -r deprecated
module purge
module load intel
module load intel-mpi intel-mkl
module load cp2k/5.1-mpi 
fullinput=$(readlink -f *inp)
baseinput=$(basename "$fullinput")
title="${baseinput%.*}"
export CP2K_DATA_DIR=/home/ongari/aiida-database/data/cp2k/data 
date_start=$(date +%s)
srun cp2k.popt -i ${title}.inp -o ${title}.out
date_end=$(date +%s)
time_run=$((date_end-date_start))
echo "Total run time: $time_run seconds"
