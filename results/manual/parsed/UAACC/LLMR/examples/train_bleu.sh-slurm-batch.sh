#!/bin/bash
#SBATCH --job-name=train
#SBATCH --account=rrg-lilimou
#SBATCH --output=/project/def-lilimou/ychao/logs/output-%j.log
#SBATCH --error=/project/def-lilimou/ychao/logs/error-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=0
#SBATCH --time=1-16:00:00
#SBATCH --exclusive

export MASTER_ADDR='127.0.0.1'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')'
export HF_HOME='/local/ssd_1/yongchang/hf'

export MASTER_ADDR=127.0.0.1
export MASTER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
export HF_HOME='/local/ssd_1/yongchang/hf'
NAME=test-bleu-regression
MODEL_NAME=t5b-dd
WS=/local/ssd_1/yongchang/
TEMP_WS=/local/hdd_1/yongchang/
DATA=$WS/data/dialogue/cleaned_ost/single-turn
CONFIG=$HF_HOME/hub/$MODEL_NAME/config.json
TOKENIZER=$HF_HOME/hub/$MODEL_NAME
SAVE=$TEMP_WS/projects/ReBTeG/ckpts/$NAME
mkdir -p $SAVE
cp $0 $SAVE/
CUDA_VISIBLE_DEVICES=0 python train_bleu.py \
  -d $DATA \
  -cn $CONFIG \
  -tn $TOKENIZER \
  -s src tgt \
  --max-tokens 2048 \
  --num-training-steps 100000 \
  -lr 1e-5 \
  --num-warmup-steps 4000 \
  --iter-per-update 8 \
  --save-dir $SAVE \
  --update-per-save 1000 \
  -mn $WS/hf/hub/$MODEL_NAME \
  --fp32 \
  --max-norm 1 \
  | tee -a $SAVE/train.log
