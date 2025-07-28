#!/bin/bash
#FLUX: --job-name=hbs-staircase-bookcorpus
#FLUX: -t=604800
#FLUX: --urgency=16

export WANDB_NAME='$EXPERIMENT'
export WANDB_RUN_GROUP='$TASK_NAME'

set -e
if [[ "$#" -ne 8 ]] ; then
    echo "Illegal number of arguments passed"
    exit 0
fi
PARTITION=$1
POS_ENC=$2
NUM_BOTTOM=$3
NUM_STAIR=$4
NUM_TOP=$5
LEARN_RATE=$6
LEN_PARAM=$7
CONTEXT_SIZE=$8
WDIR=`pwd`
SEED=1
FIXED_STRAT=true
VALID_FIXED=true
VALID_LPARAM=1
. /home/haukur/miniconda3/etc/profile.d/conda.sh
conda activate ponder
    # optimization.max_epoch=3 \
    # optimization.max_update=171600 \
WARMUP_UPDATES=570
TASK_NAME="bookcorpusopen"
EXPERIMENT="part$PARTITION.layers-$NUM_BOTTOM-$NUM_STAIR-$NUM_TOP.pos-$POS_ENC.fixed_chunk-$FIXED_STRAT.lenparam$LEN_PARAM.warmup$WARMUP_UPDATES"
EXPERIMENT="$EXPERIMENT.polynomial_decay.seed$SEED.lr$LEARN_RATE.val_chunk-$VALID_FIXED.val_lenparam$VALID_LPARAM.ctx$CONTEXT_SIZE"
export WANDB_NAME=$EXPERIMENT
export WANDB_RUN_GROUP="$TASK_NAME"
fairseq-hydra-train \
    --config-dir $WDIR/example/configs \
    --config-name staircase.bookcorpusopen \
    +task.data="$WDIR/data-bookcorpusopen/with-sym$PARTITION" \
    model.num_bottom_layers=$NUM_BOTTOM \
    model.num_staircase_layers=$NUM_STAIR \
    model.num_top_layers=$NUM_TOP \
    model.position_encoding=$POS_ENC \
        +model.use_fixed_chunking=$FIXED_STRAT \
        +model.chunk_length_parameter=$LEN_PARAM \
        +model.valid_use_fixed_chunking=$VALID_FIXED \
        +model.valid_chunk_length_parameter=$VALID_LPARAM \
        +model.max_context_size=$CONTEXT_SIZE \
    lr_scheduler.warmup_updates=$WARMUP_UPDATES \
    optimization.lr="[$LEARN_RATE]" \
    checkpoint.save_dir=$WDIR/checkpoints/$TASK_NAME-$EXPERIMENT \
    common._name=bookcorpusopen.part$PARTITION \
    common.seed=$SEED \
    +common.wandb_project="bookcorpusopen.baseline" \
    +common.user_dir=$WDIR/fairseq_user_dir
