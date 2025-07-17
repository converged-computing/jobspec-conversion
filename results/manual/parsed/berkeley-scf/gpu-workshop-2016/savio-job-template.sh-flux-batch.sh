#!/bin/bash
#FLUX: --job-name=test-gpu
#FLUX: --queue=savio2_gpu
#FLUX: -t=9000
#FLUX: --urgency=16

module load cuda
module unload intel  # do this to avoid compilation issues
