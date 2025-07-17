#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=2
#FLUX: -c=128
#FLUX: --gpus-per-task=8
#FLUX: --exclusive
#FLUX: --queue=hpg-ai
#FLUX: -t=172800
#FLUX: --urgency=16

CHECKPOINT_PATH=checkpoints_2_node
VOCAB_FILE=../data/vocab.txt
DATA_PATH=../data/uf1_TEXT_sentence
BERT_ARGS="--num-layers 24 \
    --hidden-size 1024 \
    --num-attention-heads 16 \
    --seq-length 512 \
    --max-position-embeddings 512 \
    --lr 0.0001 \
    --lr-decay-iters 990000 \
    --train-iters 200000 \
    --min-lr 0.00001 \
    --lr-warmup-fraction 0.01 \
    --micro-batch-size 4 \
    --global-batch-size 256 \
    --vocab-file $(realpath $VOCAB_FILE) \
    --split 949,50,1 \
    --fp16"
OUTPUT_ARGS="--log-interval 10 \
    --save-interval 20000 \
    --eval-interval 100 \
    --eval-iters 10 \
    --checkpoint-activations"
TRAINING_SCRIPT="$(realpath Megatron-LM/pretrain_bert.py)"
TRAINING_CMD="$TRAINING_SCRIPT \
    $BERT_ARGS \
    $OUTPUT_ARGS \
    --save $(realpath $CHECKPOINT_PATH) \
    --load $(realpath $CHECKPOINT_PATH) \
    --data-path $(realpath $DATA_PATH)"
PYTHON_PATH="singularity exec --nv \
        /apps/nvidia/containers/pytorch/20.12-py3.sif python"
PT_LAUNCH_UTILS_PATH=pt_dist_launch
source "${PT_LAUNCH_UTILS_PATH}/pt_multinode_helper_funcs.sh"
init_node_info
pwd; hostname; date
echo "Primary node: $PRIMARY"
echo "Primary TCP port: $PRIMARY_PORT"
echo "Secondary nodes: $SECONDARIES"
PT_LAUNCH_SCRIPT=$(realpath "${PT_LAUNCH_UTILS_PATH}/run_pt_on_node.sh")
echo "Running \"$TRAINING_CMD\" on each node..."
srun "$PT_LAUNCH_SCRIPT" "$(realpath $PT_LAUNCH_UTILS_PATH)" \
    "$TRAINING_CMD" "$PYTHON_PATH"
