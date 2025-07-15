#!/bin/bash
#FLUX: --job-name=desi-rep
#FLUX: --exclusive
#FLUX: -t=460800
#FLUX: --urgency=16

pwd; hostname; date
nvidia-smi
ZOOBOT_DIR=/share/nas2/walml/repos/zoobot  # be careful zoobot is up to date
PYTHON=/share/nas2/walml/miniconda3/envs/zoobot38_torch/bin/python
POSSIBLE_START_SNIPPETS=( $(seq -500 500 19500 ) )
POSSIBLE_END_SNIPPETS=( $(seq 0 500 20000 ) )
START_SNIPPET=${POSSIBLE_START_SNIPPETS[$SLURM_ARRAY_TASK_ID]}
echo Using start snippet $START_SNIPPET
END_SNIPPET=${POSSIBLE_END_SNIPPETS[$SLURM_ARRAY_TASK_ID]}
echo Using end snippet $END_SNIPPET
CHECKPOINT_FOLDER=/share/nas2/walml/repos/gz-decals-classifiers/results/benchmarks/pytorch/evo
CHECKPOINT_NAME=evo_py_co_vittiny_224_7325/checkpoints/epoch=62-step=72639.ckpt  # as above, in color
CHECKPOINT_LOC=${CHECKPOINT_FOLDER}/${CHECKPOINT_NAME}
PREDICTIONS_DIR=/share/nas2/walml/galaxy_zoo/decals/dr8/representations
srun $PYTHON /share/nas2/walml/repos/desi-predictions/make_predictions/representations/save_desi_representations.py \
    --checkpoint-loc $CHECKPOINT_LOC \
    --predictions-dir $PREDICTIONS_DIR \
    --start-snippet $START_SNIPPET \
    --end-snippet $END_SNIPPET \
    --task-id $SLURM_ARRAY_TASK_ID \
    --color
    #  \
    # --subset-loc $SUBSET_LOC \
    # --overwrite
