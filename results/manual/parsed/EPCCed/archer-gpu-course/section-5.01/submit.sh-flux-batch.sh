#!/bin/bash
#FLUX: --job-name=dinosaur-diablo-4075
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
./a.out
