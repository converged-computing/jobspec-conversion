#!/bin/bash
#FLUX: --job-name=roberta
#FLUX: -n=40
#FLUX: --exclusive
#FLUX: -t=720000
#FLUX: --priority=16

ip=`curl ifconfig.me`
module load cuda/10.1.105_418.39
module load cudnn/v7.6.2-cuda-10.1
module load nccl/2.4.2-cuda-10.1
cd /home/jmorton/research/gert/roberta-train
source ~/venvs/transformers-torch/bin/activate
DATA_DIR=../data/pfam/train/data-bin
SAVE_DIR=../data/pfam/checkpoints
TB_DIR=../data/pfam/tb
mkdir -p $SAVE_DIR
mkdir -p $TB_DIR
TOTAL_UPDATES=100000    # Total number of training steps
WARMUP_UPDATES=10000    # Warmup the learning rate over this many updates
PEAK_LR=0.0009          # Peak learning rate, adjust as needed
TOKENS_PER_SAMPLE=1024  # Max sequence length
MAX_POSITIONS=1024      # Num. positional embeddings (usually same as above)
MAX_SENTENCES=4         # Number of sequences per batch (batch size)
UPDATE_FREQ=8           # Increase the batch size by fold
PYTHON=/home/jmorton/venvs/roberta/bin/python
FAIRSEQ=/home/jmorton/venvs/roberta/bin/fairseq-train
echo `which python`
NPROC_PER_NODE=40
$(which fairseq-train) $DATA_DIR \
    --task masked_lm --criterion masked_lm \
    --sample-break-mode complete --tokens-per-sample $TOKENS_PER_SAMPLE \
    --optimizer adam --adam-betas '(0.9,0.98)' --adam-eps 1e-6 --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $PEAK_LR --warmup-updates $WARMUP_UPDATES --total-num-update $TOTAL_UPDATES \
    --dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
    --max-sentences $MAX_SENTENCES --update-freq $UPDATE_FREQ \
    --max-update $TOTAL_UPDATES --log-format simple --log-interval 100 \
    --ddp-backend=no_c10d \
    --arch roberta_base \
    --bpe gpt2 --memory-efficient-fp16 \
    --num-workers $NPROC_PER_NODE \
    --save-interval-updates 10000 \
    --save-dir $SAVE_DIR
