#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: --queue=gtx
#FLUX: -t=120
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/apps/cuda10_1/lib64'

module load intel/18.0.2 python3/3.7.0
module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/apps/cuda10_1/lib64
source $WORK/Lab1B_virtualenv/bin/activate
mkdir -p $WORK/Lab1B/output
python $WORK/Lab1B/example_keras.py > $WORK/Lab1B/output/out
