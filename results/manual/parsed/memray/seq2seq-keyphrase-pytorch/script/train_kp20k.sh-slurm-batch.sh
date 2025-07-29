#!/bin/bash
#FLUX: --job-name=rnn.kp20k.multi_test.general
#FLUX: --queue=gtx1080
#FLUX: -t=518400
#FLUX: --urgency=16

export ATTENTION='general'
export EXP_NAME='rnn.kp20k.multi_test.$ATTENTION'
export ROOT_PATH='/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch'
export DATA_NAME='kp20k'

module load cuda/10.0.130 python/3.7.0 venv/wrap
workon pytorch10
export ATTENTION="general"
export EXP_NAME="rnn.kp20k.multi_test.$ATTENTION"
export ROOT_PATH="/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch"
export DATA_NAME="kp20k"
python -m train -data_path_prefix "data/$DATA_NAME/$DATA_NAME" -vocab_path "data/$DATA_NAME/$DATA_NAME.vocab.pt" -exp "$DATA_NAME" -exp_path "$ROOT_PATH/exp/$EXP_NAME/%s.%s" -batch_size 32 -bidirectional -run_valid_every 5000 -save_model_every 5000 -bidirectional -copy_attention -attention_mode "$ATTENTION" -copy_mode "$ATTENTION"  -beam_size 32 -beam_search_batch_size 3 -train_ml -must_teacher_forcing -must_appear_in_src
