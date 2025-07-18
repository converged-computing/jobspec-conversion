#!/bin/bash
#FLUX: --job-name=test-nvidia
#FLUX: --queue=GPU
#FLUX: -t=3600
#FLUX: --urgency=16

module load singularity
srun --pty singularity shell --nv nvidia.sif
