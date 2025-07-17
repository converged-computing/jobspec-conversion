#!/bin/bash
#FLUX: --job-name=hpsg-export
#FLUX: -t=1800
#FLUX: --urgency=16

INPUT_DIR=./logon/lingo/lkb/src/tsdb/home/erg/1214
TASK_ID=$(printf '%0'$digits'd' $SLURM_ARRAY_TASK_ID)
. /home/jwei/miniconda3/etc/profile.d/conda.sh
conda activate base
echo $TASK_ID
python src/wikiwoods.py \
    --directory $INPUT_DIR/$TASK_ID \
    --output $OUTPUT_DIR/$TASK_ID \
    --derivation \
    --preprocess \
    --includena \
    --parser-error
