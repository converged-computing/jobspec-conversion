#!/bin/bash
#FLUX: --job-name=fepsA2
#FLUX: -n=2
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$gcc9libs:$LD_LIBRARY_PATH'

gcc9libs=/gpfs/u/software/erp-rhel7/modulefiles/.gcc/9.1.0/1/lib64
export LD_LIBRARY_PATH=$gcc9libs:$LD_LIBRARY_PATH
module use /gpfs/u/software/erp-spack-install/v0190_0/lmod/linux-centos7-x86_64/gcc/9.1.0
module unuse /gpfs/u/software/erp-spack-install/lmod/linux-centos7-x86_64/Core
module load gcc/9.1.0/1
module load openmpi/3.1.6
module load pumi/master-int32-sim
exe=$1; shift
args=("$@")
srun --mpi=pmi2 --cpu_bind=cores $exe ${args[@]}
