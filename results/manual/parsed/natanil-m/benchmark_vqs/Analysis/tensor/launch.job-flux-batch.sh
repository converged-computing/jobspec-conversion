#!/bin/bash
#FLUX: --job-name=myjobtest
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpuA100x8
#FLUX: -t=3600
#FLUX: --urgency=16

module reset # drop modules and explicitly load the ones needed
             # (good job metadata and reproducibility)
             # $WORK and $SCRATCH are now set
module load anaconda3_gpu  # ... or any appropriate modules
module list  # job documentation and metadata
echo "job is starting on `hostname`"
source activate global_finder310
!pip install tensorcircuit[jax]
srun python3 runner.py
echo "done"
