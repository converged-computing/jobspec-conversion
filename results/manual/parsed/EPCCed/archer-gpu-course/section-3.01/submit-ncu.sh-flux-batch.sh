#!/bin/bash
#FLUX: --job-name=evasive-pastry-1021
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --priority=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
ncu -o default ./a.out
