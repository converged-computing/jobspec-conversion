#!/bin/bash
#FLUX: --job-name=ornery-house-6347
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

module load nvidia/nvhpc
./a.out
