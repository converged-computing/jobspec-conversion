#!/bin/bash
#FLUX: --job-name=scruptious-train-5231
#FLUX: -N=2
#FLUX: --queue=regular
#FLUX: -t=3600
#FLUX: --urgency=16

export MPICH_GPU_SUPPORT_ENABLED='1'

cd /pscratch/sd/z/zjia//nccl-tests
module load cray-mpich/8.1.25
module load nccl
module load cudatoolkit
conda activate qs
export MPICH_GPU_SUPPORT_ENABLED=1
GPUSPERNODE=4
srun -u \
     --ntasks="$(( SLURM_JOB_NUM_NODES ))" \
     --ntasks-per-node=1\
     ./build/alltoall_perf -b 4G -e 4G -f 2 -d double -g ${GPUSPERNODE} -w 0 -n 10 > nccl-2nodes.log
