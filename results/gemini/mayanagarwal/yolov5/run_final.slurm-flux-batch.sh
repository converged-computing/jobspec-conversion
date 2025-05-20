#!/bin/bash

# Flux directives to request resources
# Request 1 node
#flux: -N 1
# The job script itself runs as 1 task
#flux: -n 1
# This task is allocated 8 CPU cores (derived from Slurm's --ntasks=8 on a single node)
#flux: -c 8
# This task is allocated 4 GPUs (derived from Slurm's --gres=gpu:p100:4)
#flux: -g 4
# Set wall