#!/bin/bash
#FLUX: --job-name=gpu_tf
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load singularity
nvidia-modprobe -u -c=0
singularity exec --nv tensorflow_gpu.sif python scripts/run_tensorflow_xs.py
