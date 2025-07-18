#!/bin/bash
#FLUX: --job-name=FBtest
#FLUX: -N=2
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --queue=debug
#FLUX: -t=120
#FLUX: --urgency=16

export MPICH_OFI_NIC_POLICY='NUMA'
export MPIACX_NFLAGS='256'

export MPICH_OFI_NIC_POLICY=NUMA
EXE=./main3d.gnu.TPROF.MTMPI.CUDA.ex
INPUTS="inputs_2"
export MPIACX_NFLAGS=256
srun nsys profile --stats=true -t nvtx,cuda ${EXE} ${INPUTS}
