#!/bin/bash
#FLUX: --job-name=fugly-lemon-2928
#FLUX: -N=8
#FLUX: --queue=gpu_big
#FLUX: -t=345600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/trinity/home/r.schutski/asr_speedup/venv/lib:/trinity/home/r.schutski/asr_speedup/venv/lib/python3.7'

source /trinity/home/r.schutski/asr_speedup/venv/bin/activate
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/trinity/home/r.schutski/asr_speedup/venv/lib:/trinity/home/r.schutski/asr_speedup/venv/lib/python3.7
module load mpi/openmpi-3.1.2
module load gpu/cuda-10.1
echo `pwd`
cd /trinity/home/r.schutski/asr_speedup/Automatic-Speech-Recognition/notebooks
echo 'Running script:'
echo ${@}
mpirun -np 32 \
    -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH \
    -mca pml ob1 -mca btl ^openib \
    python3 ${@}
