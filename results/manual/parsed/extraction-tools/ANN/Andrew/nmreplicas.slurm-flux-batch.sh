#!/bin/bash
#FLUX: --job-name=chocolate-leopard-5312
#FLUX: --priority=16

module purge
module load anaconda/2020.11-py3.8
module load singularity/3.7.1
module load tensorflow/2.4.1-py37
singularity run --nv /home/atz6cq/tensorflow-2.1.0-py37.sif nmreplicas.py 100 ${SLURM_ARRAY_TASK_ID} 100
