#!/bin/bash
#FLUX: --job-name=carnivorous-leopard-3181
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o systems ./a.out
