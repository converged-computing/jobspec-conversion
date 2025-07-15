#!/bin/bash
#FLUX: --job-name=tf_distributed
#FLUX: -t=1800
#FLUX: --priority=16

theScript="distributedMNIST.py"
srun shifter python $theScript
