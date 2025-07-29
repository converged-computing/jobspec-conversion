#!/bin/bash
#FLUX: --job-name=conversion_jobscript
#FLUX: --queue=regular
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=32
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
srun -n 1 python ConvertMtxToPetsc.py $SCRATCH/dist_sddmm/twitter7-permuted.mtx
