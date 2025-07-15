#!/bin/bash
#FLUX: --job-name=generate-samples-audioset
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --priority=16

source ~/.bashrc
cd /home/$USER/dev
source activate l3embedding
SRCDIR=$HOME/dev/l3embedding
OUTPUT_DIR=/beegfs/work/AudioSetSamples_environmental/urban_train
SUBSET_PATH=/scratch/jtc440/audioset_subsets/audioset_urban_train.csv
USER_IDX=0
NUM_WORKERS=4
NUM_TASKS=12
BASE_RANDOM_STATE=20180307
module purge
module load ffmpeg/intel/3.2.2
python $SRCDIR/02_generate_samples.py \
    --batch-size 1024 \
    --num-streamers 20 \
    --mux-rate 20 \
    --augment \
    --precompute \
    --num-workers $NUM_WORKERS \
    --num-distractors 2 \
    --random-state $[$BASE_RANDOM_STATE + $NUM_WORKERS * ($SLURM_ARRAY_TASK_ID - 1 + $NUM_TASKS * $USER_IDX)] \
    --include-metadata \
    $SUBSET_PATH \
    $[30000000 / $NUM_TASKS] \
    $OUTPUT_DIR
