#!/bin/bash
#FLUX: --job-name=datagenerate
#FLUX: --priority=16

srun --mpi=pmi2 python -u dataset_tool2.py create_from_images datasets/FFHQFace ../Datasets/FFHQ/FFHQ-128x128/
