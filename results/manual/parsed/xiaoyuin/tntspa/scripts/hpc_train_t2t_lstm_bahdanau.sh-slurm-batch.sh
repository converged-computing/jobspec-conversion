#!/bin/bash
#FLUX: --job-name=t2t_lstm
#FLUX: -c=8
#FLUX: --queue=gpu1,gpu2
#FLUX: -t=43200
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
USR_DIR=.
PROBLEM=translate_ensparql
MODEL=lstm_seq2seq_attention_bidirectional_encoder
HPARAMS=lstm_bahdanau_attention
srun ~/.local/bin/t2t-trainer \
  --t2t_usr_dir=$USR_DIR \
  --data_dir=$DDIR \
  --problem=$PROBLEM \
  --model=$MODEL \
  --hparams_set=$HPARAMS \
  --hparams='batch_size=1024' \
  --train_steps=30000 \
  --keep_checkpoint_max 10 \
  --output_dir=$MDIR/lstm_bahdanau_attention
