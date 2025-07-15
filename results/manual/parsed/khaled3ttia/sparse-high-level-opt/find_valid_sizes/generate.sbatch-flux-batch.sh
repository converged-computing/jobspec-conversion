#!/bin/bash
#FLUX: --job-name=dask_single_node
#FLUX: -n=128
#FLUX: --exclusive
#FLUX: --queue=disc
#FLUX: -t=3600
#FLUX: --priority=16

module load Python/3.9.5-GCCcore-10.3.0
cd /home/khaled/sparse-high-level-opt/find_valid_sizes
python generate.py --krongen /home/khaled/krongen/krongen --outdir /scratch/khaled/dask_out
