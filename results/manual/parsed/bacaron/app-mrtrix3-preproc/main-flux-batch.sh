#!/bin/bash
#FLUX: --job-name=moolicious-despacito-3372
#FLUX: --urgency=16

export SINGULARITYENV_OMP_NUM_THREADS='$OMP_NUM_THREADS'

set -x
set -e
export SINGULARITYENV_OMP_NUM_THREADS=$OMP_NUM_THREADS
time singularity exec -e --nv docker://brainlife/mrtrix3:3.0.0 ./mrtrix3_preproc.sh
