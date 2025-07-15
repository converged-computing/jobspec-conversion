#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --priority=16

srun singularity exec --nv ./containers/pytorch.sif python code/arso_to_dataframe.py
