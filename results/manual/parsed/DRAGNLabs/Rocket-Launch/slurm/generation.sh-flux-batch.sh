#!/bin/bash
#FLUX: --job-name=generation
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
python3 ../src/generation.py ../configs/PATH_TO_CONFIG.yaml
