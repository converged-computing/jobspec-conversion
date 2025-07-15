#!/bin/bash
#FLUX: --job-name=dinosaur-banana-9578
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
srun python3 ../src/inference.py ../configs/PATH_TO_CONFIG.yaml
