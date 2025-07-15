#!/bin/bash
#FLUX: --job-name=pretraining
#FLUX: -N=124
#FLUX: -c=128
#FLUX: --gpus-per-task=8
#FLUX: --exclusive
#FLUX: --queue=hpg-ai
#FLUX: -t=432000
#FLUX: --urgency=16

VOCAB_FILE=./vocab.txt
CHECKPOINT_PATH=./gatortron_4b_uf30kcased
DATA_PATH=./uf_all_ufvocab_30k_cased_NOTE_TEXT_sentence
BERT_ARGS="--num-layers 48 \
    --hidden-size 2560 \
    --tokenizer-type BertWordPieceCase \
    --num-attention-heads 40 \
    --seq-length 512 \
    --max-position-embeddings 512 \
    --lr 0.0001 \
    --lr-decay-iters 500000 \
    --seed 13 \
    --train-iters 1000000 \
    --min-lr 0.00001 \
    --lr-warmup-fraction 0.01 \
    --micro-batch-size 8 \
    --global-batch-size 3968 \
    --vocab-file $(realpath $VOCAB_FILE) \
    --split 949,50,1 \
    --DDP-impl torch \
    --tensor-model-parallel-size 2 \
    --pipeline-model-parallel-size 1 \
    --tensorboard-dir ./log \
    --fp16"
OUTPUT_ARGS="--log-interval 1000 \
    --save-interval 10000 \
    --eval-interval 5000 \
    --eval-iters 100 \
    --checkpoint-activations"
TRAINING_SCRIPT=./Megatron-LM/pretrain_bert.py
TRAINING_CMD="$TRAINING_SCRIPT \
    $BERT_ARGS \
    $OUTPUT_ARGS \
    --save $(realpath $CHECKPOINT_PATH) \
    --load $(realpath $CHECKPOINT_PATH) \
    --data-path $(realpath $DATA_PATH)"
PYTHON_PATH="singularity exec --nv ./containers/py2103.sif python"
PT_LAUNCH_UTILS_PATH=.
source "${PT_LAUNCH_UTILS_PATH}/helper.sh"
init_node_info
pwd; hostname; date
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
LAUNCH_CMD="$PYTHON_PATH \
        -m torch.distributed.launch \
              --nproc_per_node=$SLURM_GPUS_PER_TASK \
              --nnodes=$SLURM_JOB_NUM_NODES \
              --node_rank=$SLURM_NODEID \
              --master_addr=$PRIMARY \
              --master_port=$PRIMARY_PORT \
            $TRAINING_CMD"
echo "Running \"$TRAINING_CMD\" on each node..."
run_with_retry "$LAUNCH_CMD"
