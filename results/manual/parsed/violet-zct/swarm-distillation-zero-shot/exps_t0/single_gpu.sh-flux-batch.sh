#!/bin/bash
#FLUX: --job-name=xsum.lora.init.4.comb
#FLUX: -c=5
#FLUX: -t=0
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='pretrain_models/huggingface'
export HF_DATASETS_CACHE='pretrain_models/huggingface'
export HF_METRICS_CACHE='pretrain_models/huggingface'
export TRANSFORMERS_OFFLINE='1'
export WANDB_MODE='offline'
export WANDB_PROJECT='gaogao'
export WANDB_WATCH='false'

source activate tride
export TRANSFORMERS_CACHE=/home/chuntinz/tir5/pretrain_models/huggingface
export HF_DATASETS_CACHE=/home/chuntinz/tir5/pretrain_models/huggingface
export HF_METRICS_CACHE=/home/chuntinz/tir5/pretrain_models/huggingface
cache_dir=/home/chuntinz/tir5/pretrain_models/huggingface
export TRANSFORMERS_CACHE=pretrain_models/huggingface
export HF_DATASETS_CACHE=pretrain_models/huggingface
export HF_METRICS_CACHE=pretrain_models/huggingface
cache_dir=pretrain_models/huggingface
export TRANSFORMERS_OFFLINE=1
export WANDB_MODE=offline
export WANDB_PROJECT=gaogao
export WANDB_WATCH="false"
DATE=`date +%Y%m%d`
dataset="anli"
subset="none"
bsz=100
testset_name="dev_r1"
dataset="super_glue"
subset="cb"
bsz=1
testset_name="validation"
test_mode="t0"
model="bigscience/T0_3B"
model="bigscience/T0pp"
exp_name=${test_mode}.${dataset}.${testset_name}
SAVE=checkpoints/${dataset}/${DATE}/${exp_name}
rm -rf ${SAVE}; mkdir -p ${SAVE}
CUDA_VISIBLE_DEVICES=0 python -u examples/pytorch/t0-zero-shot/run_t0.py \
  --dataset_name ${dataset} --subset_name ${subset} --prompt_set_name ${dataset} --testset_name ${testset_name} \
  --model_name_or_path ${model} --per_device_train_batch_size 1  --per_gpu_eval_batch_size ${bsz} \
  --test_mode ${test_mode} --cache_dir ${cache_dir} \
  --output_dir ${SAVE} --overwrite_output_dir --fp16 \
  --disable_tqdm "True" 2>&1 | tee ${SAVE}/log.txt
