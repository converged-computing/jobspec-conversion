#!/bin/bash
#FLUX: --job-name=blank-chip-2590
#FLUX: --queue=gpu
#FLUX: -t=60
#FLUX: --urgency=16

module load nvidia/nvhpc
./a.out
