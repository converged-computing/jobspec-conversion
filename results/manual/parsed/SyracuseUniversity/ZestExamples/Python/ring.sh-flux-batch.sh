#!/bin/bash
#FLUX: --job-name=reclusive-malarkey-0587
#FLUX: -N=4
#FLUX: --queue=normal
#FLUX: --urgency=16

eval "$(/home/$(whoami)/miniconda3/bin/conda shell.bash hook)"
mpirun ./ring.py
