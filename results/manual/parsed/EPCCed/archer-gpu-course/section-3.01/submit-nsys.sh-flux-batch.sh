#!/bin/bash
#FLUX: --job-name=misunderstood-rabbit-4617
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --priority=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o systems ./a.out
