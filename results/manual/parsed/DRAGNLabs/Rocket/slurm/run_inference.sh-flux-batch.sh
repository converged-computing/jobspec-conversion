#!/bin/bash
#FLUX: --job-name=llama_inference
#FLUX: -t=144000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
nvidia-smi
mamba activate rocket
python3 ../inference.py ../configs/PATH_TO_CONFIG.yaml
