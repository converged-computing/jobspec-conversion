#!/bin/bash
#FLUX: --job-name=a100.sh
#FLUX: --queue=gpu
#FLUX: -t=180
#FLUX: --urgency=16

echo "# cloudmesh status=running progress=1 pid=$SLURM_JOB_ID"
nvidia-smi
python mlp_mnist.py
echo "# cloudmesh status=done progress=100 pid=$SLURM_JOB_ID"
