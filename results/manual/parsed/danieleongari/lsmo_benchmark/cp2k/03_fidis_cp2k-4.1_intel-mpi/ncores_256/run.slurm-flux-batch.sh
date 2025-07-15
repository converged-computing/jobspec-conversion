#!/bin/bash
#FLUX: --job-name=salted-general-9813
#FLUX: -N=10
#FLUX: -n=256
#FLUX: -t=1800
#FLUX: --priority=16

source /ssoft/spack/bin/slmodules.sh -r stable             
module purge
module load intel
module load intel-mpi intel-mkl
module load cp2k/4.1-mpi
date_start=$(date +%s)
srun cp2k.popt -i *.inp -o output.out                 #running command
date_end=$(date +%s)
time_run=$((date_end-date_start))
echo "256_cpus $time_run seconds"
rm -f GTH_BASIS_SETS POTENTIAL *xyz *restart          #remove useless big files (please!) 
