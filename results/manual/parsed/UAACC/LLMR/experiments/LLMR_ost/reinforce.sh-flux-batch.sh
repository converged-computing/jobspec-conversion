#!/bin/bash
#FLUX: --job-name=train_ost
#FLUX: --exclusive
#FLUX: -t=259200
#FLUX: --urgency=16

export TRANSFORMERS_OFFLINE='1'
export MASTER_ADDR='127.0.0.1'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_IB_GID_INDEX='mlx5_0'
export NCCL_DEBUG='WARN'
export HF_HOME='/project/def-lilimou/ychao/hf'

module load python/3.7
export TRANSFORMERS_OFFLINE=1
nodes=$(scontrol show hostnames "$SLURM_JOB_NODELIST")
nodes_array=($nodes)
head_node=${nodes_array[0]}
export MASTER_ADDR=127.0.0.1
export MASTER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
export NCCL_SOCKET_IFNAME=ib0
export NCCL_IB_GID_INDEX=mlx5_0
export NCCL_DEBUG=WARN
export HF_HOME='/project/def-lilimou/ychao/hf'
NAME=t5t0pce_rl_ost
LLMR=/home/mrli/scratch/projects/LLMR/ckpts/t5b-t0p-ost/model-004k
t5_base=/project/def-lilimou/ychao/hf/hub/t5-base
REWARD_MODEL_NAME=t0-3b
WS=/project/def-lilimou/ychao
DATA=$WS/data/dialogue/cleaned_ost/single-turn
CONFIG=$HF_HOME/hub/t5-base/config.json
TOKENIZER=$HF_HOME/hub/t5-base
SAVE=/home/mrli/scratch/projects/LLMR/ckpts/LLMR_ost
mkdir -p $SAVE
cp $0 $SAVE/
python reinforce.py \
  -d $DATA \
  -cn $CONFIG \
  -tn $TOKENIZER \
  -s src src \
  --max-tokens 512 \
  --num-training-steps 100000 \
  -lr 1e-6 \
  --num-warmup-steps 5000 \
  --iter-per-update 16 \
  --save-dir $SAVE \
  -mn $LLMR \
  --reward-model $WS/hf/hub/$REWARD_MODEL_NAME \
  --fp32 \
  --topk 5\
  --scheduler constant\
  --max-norm 1 \
  --softmax \
  --entropy 0.1 \
  --denom 100 \
  --deterministic \
  --reward-clip 1 \
  --template templates/dialogue_T0.txt \
  --update-per-save 1000 \
  --update-per-log 1 \
  | tee -a $SAVE/train.log
