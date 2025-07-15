#!/bin/bash
#FLUX: --job-name=rnn.stackexchange.multi_test.general
#FLUX: --queue=titanx
#FLUX: -t=518400
#FLUX: --urgency=16

export ATTENTION='general'
export EXP_NAME='rnn.stackexchange.multi_test.$ATTENTION'
export ROOT_PATH='/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch'
export DATA_NAME='stackexchange'

export ATTENTION="general"
export EXP_NAME="rnn.stackexchange.multi_test.$ATTENTION"
export ROOT_PATH="/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch"
export DATA_NAME="stackexchange"
srun python -m train -data_path_prefix "data/$DATA_NAME/$DATA_NAME" -vocab_path "data/$DATA_NAME/$DATA_NAME.vocab.pt" -exp "$DATA_NAME" -exp_path "$ROOT_PATH/exp/$EXP_NAME/%s.%s" -batch_size 128 -bidirectional -run_valid_every 2000 -save_model_every 2000 -bidirectional -copy_attention -attention_mode "$ATTENTION" -copy_mode "$ATTENTION"  -beam_size 32 -beam_search_batch_size 1 -train_ml -must_teacher_forcing -must_appear_in_src
