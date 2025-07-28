#!/bin/bash
#FLUX: --job-name=NSBH
#FLUX: -N=10
#FLUX: -t=360000
#FLUX: --urgency=16

export MKL_NUM_THREADS='1'
export MKL_DYNAMIC='FALSE'
export OMP_NUM_THREADS='1'
export MPI_PER_NODE='14'

export MKL_NUM_THREADS="1"
export MKL_DYNAMIC="FALSE"
export OMP_NUM_THREADS=1
export MPI_PER_NODE=14
mpirun python sim_nsbh_analysis_4NS.py
