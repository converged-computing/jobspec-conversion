#!/bin/bash
#FLUX: --job-name=stinky-muffin-5997
#FLUX: -c=6
#FLUX: -t=360
#FLUX: --urgency=16

module load python/3.7
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --upgrade pip
make requirements
make train PROCESSED_DATA_PATH="/home/albanmdb/scratch/datasets/NTU_RGB+D/" \
			EVALUATION_TYPE=cross_subject \
			MODEL_TYPE=FUSION \
			USE_POSE=True \
			USE_IR=False \
			PRETRAINED=False \
			USE_CROPPED_IR=False \
			LEARNING_RATE=1e-4 \
			WEIGHT_DECAY=0.0 \
			GRADIENT_THRESHOLD=10 \
			EPOCHS=15 \
			BATCH_SIZE=16 \
			ACCUMULATION_STEPS=1 \
			SUB_SEQUENCE_LENGTH=20 \
			AUGMENT_DATA=False \
			MIRROR_SKELETON=False \
			EVALUATE_TEST=True \
			SEED=1
