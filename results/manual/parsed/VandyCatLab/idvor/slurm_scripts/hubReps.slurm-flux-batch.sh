#!/bin/bash
#FLUX: --job-name=confused-blackbean-0198
#FLUX: -c=2
#FLUX: --queue=pascal
#FLUX: -t=21600
#FLUX: --urgency=16

date
singularity exec --nv ../pyTF.sif python ../python_scripts/hubReps.py -i ${SLURM_ARRAY_TASK_ID} -d /scratch/chowjk/tensorflow_datasets -f ~/idvor/python_scripts/hubModels.json
date
