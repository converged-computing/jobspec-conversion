#!/bin/bash -l
#SBATCH --nodes=2             #max 2 for debug
#SBATCH --ntasks=49	      #28 cpus per node on fidis
#SBATCH --time=1:00:00        #max 1h for debug
##SBATCH --partition=debug    #debug partition
##SBATCH --constraint=E5v4    #constrain fidis's cpu
##SBATCH --constraint=s6g1    #constrain gacrux's cpu (~1.5x faster)

source /ssoft/spack/bin/slmodules.sh -r deprecated
module purge
module load intel
module load intel-mpi intel-mkl
module load cp2k/5.1-mpi

fullinput=$(readlink -f *inp)
baseinput=$(basename "$fullinput")
title="${baseinput%.*}"

AIIDA_CODE_DIR="/work/lsmo/aiida-lsmo-codes"
export CP2K_DATA_DIR=$AIIDA_CODE_DIR/data/cp2k/data

date_start=$(date +%s)
srun cp2k.popt -i ${title}.inp -o ${title}.out
date_end=$(date +%s)
time_run=$((date_end-date_start))
echo "Total run time: $time_run seconds"
