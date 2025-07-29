#!/bin/bash
#FLUX: --job-name=quirky-omelette-9410
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

module load nvidia/nvhpc
./a.out
