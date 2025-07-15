#!/bin/bash
#FLUX: --job-name=tf_distributed
#FLUX: -c=16
#FLUX: --queue=gpuq
#FLUX: -t=3600
#FLUX: --priority=16

theImage="docker://nvcr.io/nvidia/tensorflow:22.04-tf2-py3"
module load singularity
theScript="distributedMNIST.py"
srun singularity exec --nv -e -B fake_home:$HOME $theImage python $theScript
