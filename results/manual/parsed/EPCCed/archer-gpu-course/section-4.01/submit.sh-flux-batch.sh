#!/bin/bash
#FLUX --job-name=conspicuous-car-8784
#FLUX --queue=gpu
#FLUX -t=120
#FLUX --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o streamprofile ./a.out
