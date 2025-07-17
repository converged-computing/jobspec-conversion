#!/bin/bash
#FLUX: --job-name=bert
#FLUX: -n=4
#FLUX: --queue=rtx
#FLUX: -t=21600
#FLUX: --urgency=16

module load cuda/10.1
source $HOME/programs/anaconda3/bin/activate
conda activate SUMMA
CHECKPOINT_PATH=checkpoint
DATA_PATH=/work2/07789/xuqifan/frontera/dataset/bert_data/my-bert_text_sentence
VOCAB_FILE=/work/07789/xuqifan/frontera/dataset/bert_data/vocab.txt
srun python pretrain_bert.py \
       --num-layers 2 \
       --hidden-size 128 \
       --num-attention-heads 2 \
       --batch-size 64 \
       --seq-length 128 \
       --max-position-embeddings 128 \
       --checkpoint-activations \
       --distribute-checkpointed-activations \
       --train-iters 50000 \
       --save $CHECKPOINT_PATH \
       --load $CHECKPOINT_PATH \
       --data-path $DATA_PATH \
       --vocab-file $VOCAB_FILE \
       --tensorboard-dir $CHECKPOINT_PATH \
       --data-impl mmap \
       --split 949,50,1 \
       --distributed-backend nccl \
       --lr 0.0001 \
       --min-lr 0.00001 \
       --lr-decay-style linear \
       --lr-decay-iters 990000 \
       --weight-decay 1e-2 \
       --clip-grad 1.0 \
       --warmup .01 \
       --log-interval 20 \
       --save-interval 1000 \
       --eval-interval 200 \
       --eval-iters 10
