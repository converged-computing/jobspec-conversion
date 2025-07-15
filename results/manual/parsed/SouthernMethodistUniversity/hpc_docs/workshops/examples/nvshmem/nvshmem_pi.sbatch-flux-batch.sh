#!/bin/bash
#FLUX: --job-name=peachy-noodle-8418
#FLUX: --priority=16

echo $SLURM_JOB_PARTITION
module purge
module load nvhpc-22.2       # Alternatively nvhpc-21.2, nvhpc-21.9
NVSHMEM_HOME=/hpc/applications/nvidia/hpc_sdk/2022_22.2/Linux_x86_64/22.2/comm_libs/11.2/nvshmem
GCC_HOME=/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-7.3.0/gcc-9.2.0-6zgrndxveon2m5mjhltrqccdcewrdktx/bin
nvcc -ccbin=$GCC_HOME -x cu -arch=sm_60 -rdc=true -I $NVSHMEM_HOME/include\
 -L $NVSHMEM_HOME/lib -lnvshmem -lcuda -o nvshmem_pi nvshmem_pi.cpp
srun nvshmem_pi
