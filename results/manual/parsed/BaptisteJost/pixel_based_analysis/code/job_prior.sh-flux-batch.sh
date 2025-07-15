#!/bin/bash
#FLUX: --job-name=red-muffin-2515
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
srun -n 8 -c 16 --cpu_bind=cores python /global/homes/j/jost/these/pixel_based_analysis/code/prior_precison_gridding.py
srun -n 1 -c 64 --cpu_bind=cores python /global/homes/j/jost/these/pixel_based_analysis/code/graph_prior_precision.py
