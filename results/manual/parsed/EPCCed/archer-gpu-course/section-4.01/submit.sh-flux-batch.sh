#!/bin/bash
#FLUX: --job-name=fat-poo-5817
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o streamprofile ./a.out
