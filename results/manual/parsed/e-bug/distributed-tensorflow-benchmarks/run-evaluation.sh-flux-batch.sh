#!/bin/bash
#FLUX: --job-name=mlcomm
#FLUX: -c=12
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=18000
#FLUX: --urgency=16

echo "Number of nodes: " 1
module load daint-gpu
module load TensorFlow/1.3.0-CrayGNU-17.08-cuda-8.0-python3
module load craype-ml-plugin-py3/1.0.1
srun -u --exclusive --cpu_bind=none /scratch/snx3000/${USER}/cray-tensorflow/evaluate_checkpoints.sh \
    /scratch/snx3000/${USER}/cray-tf-traindir/rank0 \
    /scratch/snx3000/${USER}/cray-tensorflow/tmp/
