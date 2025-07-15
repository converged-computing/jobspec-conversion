#!/bin/bash
#FLUX: --job-name=tf_distributed
#FLUX: -t=3600
#FLUX: --priority=16

theImage="nvcr.io/nvidia/tensorflow:22.04-tf2-py3"
shifterimg pull $theImage
theScript="distributedMNIST.py"
srun shifter --image="$theImage" python $theScript
