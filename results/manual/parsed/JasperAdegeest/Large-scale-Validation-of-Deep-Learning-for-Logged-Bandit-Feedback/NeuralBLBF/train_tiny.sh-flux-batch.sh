#!/bin/bash
#FLUX: --job-name=small
#FLUX: -c=3
#FLUX: --queue=gpu_shared
#FLUX: -t=14400
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$HOME/IR2'

module purge
module load eb
module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export PYTHONPATH=$PYTHONPATH:$HOME/IR2
DATA_TRAIN="$HOME/IR2/data/vw_compressed_train"
DATA_TEST="$HOME/IR2/data/vw_compressed_validate"
F2K_FILE="$HOME/IR2/data/features_to_keys.json"
MODEL_PATH="$HOME/IR2/data/models"
EPOCHS=10
LAMBDA=1
EMBD_DIM=64
MODEL_TYPE="TinyEmbedFFNN"
LR=0.001
python3 -m NeuralBLBF --device_id 0 --train $DATA_TRAIN --test $DATA_TEST --epochs $EPOCHS \
    --stop_idx 100000000 --step_size 20000000 --batch_size 128 --enable_cuda --embedding_dim $EMBD_DIM \
    --model $MODEL_TYPE --save --lamb $LAMBDA --feature_dict_name $F2K_FILE --save_model_path $MODEL_PATH \
    --learning_rate $LR
