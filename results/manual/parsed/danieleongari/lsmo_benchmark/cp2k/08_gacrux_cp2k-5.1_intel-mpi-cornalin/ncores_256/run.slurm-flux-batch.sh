#!/bin/bash
#FLUX: --job-name=milky-rabbit-9474
#FLUX: -N=10
#FLUX: -n=256
#FLUX: -t=1800
#FLUX: --urgency=16

source /ssoft/spack/bin/slmodules.sh -r deprecated   
module load intel
module load intel-mpi intel-mkl
module load cp2k/5.1-mpi
date_start=$(date +%s)
srun /ssoft/spack/cornalin/v2/opt/spack/linux-rhel7-x86_E5v4_Mellanox/intel-17.0.2/cp2k-5.1-gke4ujsx5qhx6zt7ncfo22hajqhp6n6b/bin/cp2k.popt -i *.inp -o output.out                 #running command
date_end=$(date +%s)
time_run=$((date_end-date_start))
echo "256_cpus $time_run seconds"
rm -f GTH_BASIS_SETS POTENTIAL *xyz *restart          #remove useless big files (please!) 
