#!/bin/bash
#FLUX: --job-name=Preprocess
#FLUX: --queue=regular
#FLUX: -t=28861
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
conda activate jax
wait
