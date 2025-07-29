#!/bin/bash
#FLUX: --job-name=train-kp20k-bidirectional-TeacherForcing-IFCF
#FLUX: --queue=titanx
#FLUX: -t=518400
#FLUX: --urgency=16

export EXP_NAME='rnn.teacher_forcing.input_feeding_copy_feeding'
export ATTENTION='general'
export ROOT_PATH='/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch'
export DATA_NAME='kp20k'

export EXP_NAME="rnn.teacher_forcing.input_feeding_copy_feeding"
export ATTENTION="general"
export ROOT_PATH="/zfs1/pbrusilovsky/rum20/seq2seq-keyphrase-pytorch"
export DATA_NAME="kp20k"
srun python -m train -data data/$DATA_NAME/$DATA_NAME -vocab data/$DATA_NAME/$DATA_NAME.vocab.pt  -exp_path "$ROOT_PATH/exp/$EXP_NAME/%s.%s" -model_path "$ROOT_PATH/model/$EXP_NAME/%s.%s" -pred_path "$ROOT_PATH/pred/$EXP_NAME/%s.%s" -exp "$DATA_NAME" -batch_size 128 -bidirectional -run_valid_every 2000 -save_model_every 10000 -beam_size 16 -beam_search_batch_size 32 -train_ml -attention_mode $ATTENTION -copy_attention -copy_mode $ATTENTION -input_feeding -copy_input_feeding -must_teacher_forcing
