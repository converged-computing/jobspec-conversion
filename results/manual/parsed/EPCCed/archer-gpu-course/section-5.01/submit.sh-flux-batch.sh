#!/bin/bash
#FLUX --job-name=doopy-parrot-0013
#FLUX --queue=gpu
#FLUX -t=120
#FLUX --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
./a.out
