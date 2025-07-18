#!/bin/bash
#FLUX: --job-name=moolicious-leopard-8635
#FLUX: -n=5
#FLUX: -t=0
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH'
export CPATH='/opt/cudnn-8.0/include:$CPATH'
export LIBRARY_PATH='/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH'

set -x  # echo commands to stdout
set -e  # exit on error
module load cuda-8.0
module load cudnn-8.0-5.1
export LD_LIBRARY_PATH=/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH
export CPATH=/opt/cudnn-8.0/include:$CPATH
export LIBRARY_PATH=/opt/cudnn-8.0/lib64:$LD_LIBRARY_PATH
home=/projects/tir1/users/chuntinz/pytorch_703
pushd $home
model_name=mle_rl_comb
load_model_name=mle_update
python nmt.py \
    --train_src ./en-de/train.en-de.low.filt.de \
    --train_tgt ./en-de/train.en-de.low.filt.en \
    --dev_src ./en-de/valid.en-de.low.de \
    --dev_tgt ./en-de/valid.en-de.low.en \
    --test_src ./en-de/test.en-de.low.de \
    --test_tgt ./en-de/test.en-de.low.en \
    --vocab ./vocab.bin \
    --dropout 0.5\
    --decode_max_time_step 100\
    --batch_size 16\
    --sample_size  15\
    --reward_type "combined" \
    --model_type rl \
    --log_every 50\
    --save_to $model_name\
    --load_model $load_model_name.bin \
    --mode train\
    --update_freq 3\
    --valid_niter 1000 \
    --lr 0.0001 \
    --cuda\
python nmt.py \
    --train_src ./en-de/train.en-de.low.filt.de \
    --train_tgt ./en-de/train.en-de.low.filt.en \
    --dev_src ./en-de/valid.en-de.low.de \
    --dev_tgt ./en-de/valid.en-de.low.en \
    --test_src ./en-de/test.en-de.low.de \
    --test_tgt ./en-de/test.en-de.low.en \
    --vocab ./vocab.bin \
    --decode_max_time_step 200\
    --batch_size 32\
    --model_type ml \
    --log_every 50\
    --load_model $model_name.bin \
    --mode test\
    --valid_niter 1000 \
