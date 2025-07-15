#!/bin/bash
#FLUX: --job-name=bloated-lettuce-2637
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --priority=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
./a.out
