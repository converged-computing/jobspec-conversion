#!/bin/bash
#FLUX: --job-name=generate-samples-audioset
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --priority=16

source ~/.bashrc
cd /home/$USER/dev
source activate l3embedding
SRCDIR=''
OUTPUT_DIR=''
SUBSET_PATH=''
USER_IDX=0
NUM_WORKERS=16
NUM_TASKS=20
BASE_RANDOM_STATE=20180118
module purge
module load ffmpeg/intel/3.2.2
python $SRCDIR/02_generate_samples.py \
    --batch-size 16 \
    --num-streamers 64 \
    --mux-rate 2 \
    --augment \
    --precompute \
    --num-workers $NUM_WORKERS \
    --num-distractors 1 \
    --random-state $[$BASE_RANDOM_STATE + $NUM_WORKERS * ($SLURM_ARRAY_TASK_ID - 1 + $NUM_TASKS * $USER_IDX)] \
    --include-metadata \
    $SUBSET_PATH \
    $[1000 / $NUM_TASKS] \
    $OUTPUT_DIR
