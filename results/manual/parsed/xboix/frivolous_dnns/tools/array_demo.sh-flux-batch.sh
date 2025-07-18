#!/bin/bash
#FLUX: --job-name=demo
#FLUX: --queue=normal
#FLUX: -t=43200
#FLUX: --urgency=16

cd /om/user/scasper/workspace/
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/train.py ${SLURM_ARRAY_TASK_ID}
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/get_activations.py ${SLURM_ARRAY_TASK_ID}
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/get_redundancy.py ${SLURM_ARRAY_TASK_ID}
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/get_robustness.py ${SLURM_ARRAY_TASK_ID}
