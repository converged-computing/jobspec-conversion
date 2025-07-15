#!/bin/bash
#FLUX: --job-name=hello-destiny-4001
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --priority=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o streamprofile ./a.out
