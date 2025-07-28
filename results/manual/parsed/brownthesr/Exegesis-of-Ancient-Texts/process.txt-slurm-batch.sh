#!/bin/bash
#FLUX: --job-name=Processing Vectors
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
source activate script
python3 generation/mean_masks.py -u 
