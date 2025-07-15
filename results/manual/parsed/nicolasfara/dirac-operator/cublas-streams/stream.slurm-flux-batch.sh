#!/bin/bash
#FLUX: --job-name=gpu-test
#FLUX: --queue=shortvolta
#FLUX: --urgency=16

module load cuda/10.0
module load openmpi/4.0.1-cuda10.0
srun ./cublas-streams $@
