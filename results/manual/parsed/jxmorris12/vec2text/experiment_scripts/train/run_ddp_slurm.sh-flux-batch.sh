#!/bin/bash
#FLUX: --job-name=loopy-destiny-7686
#FLUX: -c=16
#FLUX: --queue=rush,gpu
#FLUX: -t=2419200
#FLUX: --urgency=16

export BASEDIR='/home/jxm3/research/retrieval/inversion/vec2text/'
export NCCL_P2P_LEVEL='NVL'

export BASEDIR="/home/jxm3/research/retrieval/inversion/vec2text/"
export NCCL_P2P_LEVEL=NVL
echo "hostname:"
hostname
echo "nvidia-smi"
nvidia-smi
echo "running df -h TMPDIR ($TMPDIR).."
df -h $TMPDIR
echo "start:: running command with BASEDIR=$BASEDIR"
cd $BASEDIR
pwd
/home/jxm3/.conda/envs/torch/bin/torchrun run.py --per_device_train_batch_size 128 --per_device_eval_batch_size 128 --max_seq_length 128 --model_name_or_path t5-base --dataset_name msmarco --embedder_model_name gtr_base --num_repeat_tokens 16 --embedder_no_grad True --num_train_epochs 100 --max_eval_samples 500 --eval_steps 20000 --warmup_steps 10000 --bf16=1 --use_wandb=1 --use_frozen_embeddings_as_input True --experiment inversion --lr_scheduler_type constant_with_warmup --exp_group_name oct-sbert --learning_rate 0.001 --output_dir /home/jxm3/research/retrieval/inversion/vec2text//saves/sbert-1 --save_steps 2000
echo "finished:: running command with BASEDIR=$BASEDIR"
