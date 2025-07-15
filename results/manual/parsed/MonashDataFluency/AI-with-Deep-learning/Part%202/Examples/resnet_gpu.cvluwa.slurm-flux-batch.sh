#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: -n=3
#FLUX: --queue=desktop
#FLUX: --priority=16

export EPOCHS='5'

container=/usr/local/sv2/juflocu.sif
script="ResNet_Example.py"
cmd="$PWD/$script"
module load singularity
nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 1 > gpu_util-$SLURM_JOBID.csv &
export EPOCHS=5
singularity exec  --nv $container /usr/bin/python3 "$cmd"
