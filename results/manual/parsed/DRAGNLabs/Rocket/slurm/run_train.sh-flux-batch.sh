#!/bin/bash
#FLUX: --job-name=fuzzy-parrot-4681
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
srun python3 ../train.py ../configs/PATH_TO_CONFIG.yaml
