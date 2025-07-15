#!/bin/bash
#FLUX: --job-name=hello-fork-9978
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: --priority=16

eval "$(/home/$(whoami)/miniconda3/bin/conda shell.bash hook)"
mpirun ./ring.py
