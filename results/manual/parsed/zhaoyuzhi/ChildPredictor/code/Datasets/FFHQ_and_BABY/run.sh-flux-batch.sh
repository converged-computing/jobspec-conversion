#!/bin/bash
#FLUX: --job-name=datagenerate
#FLUX: --urgency=16

srun --mpi=pmi2 python -u dataset_tool.py create_from_images datasets/mixtureFace ./FFHQ-128x128
