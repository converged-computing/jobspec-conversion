#!/bin/bash
#FLUX: --job-name=desi-pred
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: -t=460800
#FLUX: --urgency=16

pwd; hostname; date
nvidia-smi
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot  # be careful zoobot is up to date
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot38_torch/bin/python
POSSIBLE_START_SNIPPETS=( $(seq -20 20 2180 ) )
POSSIBLE_END_SNIPPETS=( $(seq 0 20 2200 ) )
START_SNIPPET_INDEX=${POSSIBLE_START_SNIPPETS[$SLURM_ARRAY_TASK_ID]}
echo Using start snippet $START_SNIPPET_INDEX
END_SNIPPET_INDEX=${POSSIBLE_END_SNIPPETS[$SLURM_ARRAY_TASK_ID]}
echo Using end snippet $END_SNIPPET_INDEX
PREDICTIONS_DIR=data/desi/predictions/rings
MODEL=maxvit_rings_dirichlet
GALAXIES=desi
srun $PYTHON /share/nas2/walml/repos/zoobot-predictions/make_predictions/a_make_bulk_catalog_predictions.py \
    +cluster.start_snippet_index=$START_SNIPPET_INDEX \
    +cluster.end_snippet_index=$END_SNIPPET_INDEX \
    +cluster.task_id=$SLURM_ARRAY_TASK_ID \
    +predictions_dir=$PREDICTIONS_DIR \
    +cluster=manchester \
    +galaxies=$GALAXIES \
    +model=$MODEL \
    ++cluster.batch_size=128
