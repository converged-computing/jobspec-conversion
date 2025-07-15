#!/bin/bash
#FLUX: --job-name=singlegpu_gputest_example
#FLUX: --gpus-per-task=1
#FLUX: --queue=small-g
#FLUX: -t=300
#FLUX: --priority=16

srun singularity exec lumi_pytorch_rocm_demo.sif python3 pytorch_singlegpu_gputest.py
