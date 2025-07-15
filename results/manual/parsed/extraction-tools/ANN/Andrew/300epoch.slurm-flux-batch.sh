#!/bin/bash
#FLUX: --job-name=lovable-pot-6424
#FLUX: --priority=16

module purge
module load anaconda/2019.10-py3.7
module load singularity/3.5.2
module load tensorflow/2.1.0-py37
singularity run --nv /home/atz6cq/tensorflow-2.1.0-py37.sif Method2epochs.py ${SLURM_ARRAY_TASK_ID} 300
