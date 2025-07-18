#!/bin/bash
#FLUX: --job-name=ASR-DDP-check
#FLUX: -t=7200
#FLUX: --urgency=16

source activate pt
nvidia-smi
echo $PATH
cd $SLURM_SUBMIT_DIR
echo $SLURM_JOB_NODELIST
python -m torch.distributed.launch --nproc_per_node=2 main.py \
        --nnodes 2 \
        --gpus 2 \
        --node_rank ${SLURM_ARRAY_TASK_ID} \
        --nepochs 60 \
        --epochs-done 0 \
        --train-path '/users/PAS1939/vishal/datasets/librispeech/train_full_960.csv' \
        --logging-file 'logs/conf_16L128H4A_asr.log' \
        --save-path '/users/PAS1939/vishal/saved_models/debug_ddp.pth.tar' \
        --ckpt-path '' \
        --enc-type 'conf' \
        --batch-size 512 \
        --bsz-small 8 \
        --in-dim 960 \
        --n-layer 16 \
        --hid-tr 128 \
        --nhead 4 \
        --hid-pr 1024 \
        --lr 0.001 \
        --clip 5.0 \
        --dropout 0.25
