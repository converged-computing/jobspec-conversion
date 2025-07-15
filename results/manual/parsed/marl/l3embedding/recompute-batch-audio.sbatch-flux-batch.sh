#!/bin/bash
#FLUX: --job-name=recompute-batch-audio
#FLUX: -c=20
#FLUX: -t=604800
#FLUX: --priority=16

source ~/.bashrc
cd /home/$USER/dev
source activate l3embedding-new
SRCDIR=$HOME/dev/l3embedding
BATCH_DIR="/beegfs/work/AudioSetSamples_environmental/urban_train"
SUBSET_PATH="/home/jtc440/dev/audioset_urban_train.csv"
module purge
python $SRCDIR/recompute_batch_audio.py \
    $BATCH_DIR \
    $SUBSET_PATH \
    --n-jobs 20 \
    --verbose 50
