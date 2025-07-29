#!/bin/bash
#FLUX: --job-name=DL-HW3
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module load singularity
singularity exec docker://unlhcc/tensorflow-gpu python3 -u $@
