#!/bin/bash
#FLUX: --job-name=tensorflow  # The job name
#FLUX: --priority=16

module load singularity
singularity exec --nv /moto/opt/singularity/tensorflow-1.13-gpu-py3-moto.simg python train_STG_circuit.py med $1 $2 $3 $4 $5 
