#!/bin/bash
#FLUX: --job-name=astute-blackbean-8299
#FLUX: -n=4
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=1200
#FLUX: --urgency=16

export SLURM_CPU_BIND='cores'

module purge && module load cgpu esslurm tensorflow/2.4.1-gpu
export SLURM_CPU_BIND="cores"
srun python mesh_nbody_benchmark.py --nc=512 --batch_size=1 --nx=2 --ny=2 --hsize=32
