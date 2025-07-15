#!/bin/bash
#FLUX: --job-name=goodbye-cupcake-1867
#FLUX: -c=8
#FLUX: -t=28800
#FLUX: --urgency=16

module load TensorFlow/1.8.0-foss-2018a-Python-3.6.4-CUDA-9.2.88
DDIR=data/monument_600
MDIR=output/models
if [ -n "$1" ]
    then DDIR=$1
fi
if [ -n "$2" ]
    then MDIR=$2
fi
srun python3 -m nmt.nmt.nmt \
    --src=en --tgt=sparql \
    --hparams_path=nmt_hparams/neural_sparql_machine_attention_bahdanau_adam_lr0_0005.json \
    --out_dir=$MDIR/neural_sparql_machine_attention_bahdanau_adam_lr0_0005 \
    --vocab_prefix=$DDIR/vocab \
    --train_prefix=$DDIR/train \
    --dev_prefix=$DDIR/dev \
    --test_prefix=$DDIR/test
exit 0
