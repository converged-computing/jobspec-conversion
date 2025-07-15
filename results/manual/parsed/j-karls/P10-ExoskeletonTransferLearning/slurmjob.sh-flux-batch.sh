#!/bin/bash
#FLUX: --job-name=joncoron
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

srun singularity exec --nv tensorflow_20.02-tf1-py3.sif python P10-ExoskeletonTransferLearning/meta_temp.py
