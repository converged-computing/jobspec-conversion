#!/bin/bash
#FLUX: --job-name=purple-blackbean-4890
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --priority=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o graphprofile ./a.out
