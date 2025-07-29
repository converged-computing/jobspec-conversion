#!/bin/bash
#FLUX: --job-name=rnn.kp20k.multi_test.general
#FLUX: --queue=gtx1080
#FLUX: -t=518400
#FLUX: --urgency=16

export EXP_NAME='rnn.kp20k.multi_test.general'
export ATTENTION='general'
export ROOT_PATH='/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch'
export DATA_NAME='kp20k'

export EXP_NAME="rnn.kp20k.multi_test.general"
export ATTENTION="general"
export ROOT_PATH="/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch"
export DATA_NAME="kp20k"
srun python -m train -data data/$DATA_NAME/$DATA_NAME -vocab data/$DATA_NAME/$DATA_NAME.vocab.pt -exp "$DATA_NAME" -batch_size 128 -bidirectional -run_valid_every 5000 -save_model_every 5000 -beam_size 32 -beam_search_batch_size 3 -train_ml
