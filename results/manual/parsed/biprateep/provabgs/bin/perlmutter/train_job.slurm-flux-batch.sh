#!/bin/bash
#FLUX: --job-name=doopy-earthworm-5539
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

export SLURM_CPU_BIND="cores"
module load tensorflow/2.6.0
srun python /global/homes/b/bid13/provabgs/bin/emulator.py nmf 100 0 50 8 256 2048
