#!/bin/bash
#FLUX: --job-name=awdlstm
#FLUX: -n=4
#FLUX: --queue=a100
#FLUX: -t=172800
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=$(ncvd)
module load python/anaconda-python-3.7
module load software/TensorFlow-A100-GPU
start=$(date +%s)
echo "Starting script..."
python3 -u awd_lstm/main.py \
    --descriptive_name "awd_lstm_combined" \
    --data data/combined/isizulu \
    --save_history "logs/awd_lstm/$(date "+%Y-%m-%d_%H-%M-%S").txt" \
    --emsize 800 \
    --nhid 1150 \
    --nlayers 3 \
    --lr 30.0 \
    --clip 0.25 \
    --epochs 500 \
    --batch_size 32 \
    --bptt 70 \
    --dropout 0.2 \
    --dropouth 0.2 \
    --dropouti 0.2 \
    --dropoute 0.1 \
    --wdrop 0.2 \
    --seed 1882 \
    --patience 3 \
    --nonmono 8 \
    --cuda \
    --when 40 80 120 \
end=$(date +%s)
echo "Elapsed Time: $(($end-$start)) seconds"
