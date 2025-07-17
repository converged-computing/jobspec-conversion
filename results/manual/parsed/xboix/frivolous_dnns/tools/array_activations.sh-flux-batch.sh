#!/bin/bash
#FLUX: --job-name=get_activations
#FLUX: --queue=cbmm
#FLUX: -t=3600
#FLUX: --urgency=16

cd /om/user/scasper/workspace/
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/get_activations.py ${SLURM_ARRAY_TASK_ID}
