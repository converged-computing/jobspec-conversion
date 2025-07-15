#!/bin/bash
#FLUX: --job-name=generate-l3embedding-samples
#FLUX: -c=8
#FLUX: -t=604800
#FLUX: --priority=16

source ~/.bashrc
cd /home/$USER/dev
source activate l3embedding-cpu
SRCDIR=$HOME/dev/l3embedding
L3_MODEL_PATH=''
L3_POOLING_TYPE='original'
US8K_PATH=/beegfs/jtc440/UrbanSound8K
METADATA_PATH=$US8K_PATH/metadata/UrbanSound8K.csv
DATA_DIR=$US8K_PATH/audio
OUTPUT_DIR=/scratch/jtc440/sonyc-usc
DATASET='us8k'
module purge
module load ffmpeg/intel/3.2.2
python $SRCDIR/05_generate_embedding_samples.py \
    --random-state 20180302 \
    --verbose \
    --features 'l3' \
    --l3embedding-model-path $L3_MODEL_PATH \
    --l3embedding-pooling-type $L3_POOLING_TYPE \
    --hop-size 0.1 \
    --gpus 0 \
    --fold $SLURM_ARRAY_TASK_ID \
    --us8k-metadata-path $METADATA_PATH \
    $DATASET \
    $DATA_DIR \
    $OUTPUT_DIR
