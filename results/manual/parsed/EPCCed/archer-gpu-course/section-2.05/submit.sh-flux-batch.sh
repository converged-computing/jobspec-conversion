#!/bin/bash
#FLUX: --job-name=delicious-noodle-6977
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

module load nvidia/nvhpc
./a.out
