#!/bin/bash
#FLUX: --job-name=multinode_job
#FLUX: -N=2
#FLUX: -c=10
#FLUX: -t=3600
#FLUX: --urgency=16

srun --nodes=2 --ntasks-per-node=1 --cpus-per-task=10 --mem-per-cpu=2GB --gpus=a100:4 --time=1:00:00 multi_node_helper.sh `hostname` `pwd` 2 2
