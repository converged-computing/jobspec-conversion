#!/bin/bash
#FLUX: --job-name=doopy-cupcake-5182
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
./async
