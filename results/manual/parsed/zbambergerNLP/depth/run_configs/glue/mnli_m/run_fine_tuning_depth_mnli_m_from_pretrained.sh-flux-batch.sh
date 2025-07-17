#!/bin/bash
#FLUX: --job-name=principled-pre-training
#FLUX: -c=32
#FLUX: --queue=nlp
#FLUX: --urgency=16

export DS_SKIP_CUDA_CHECK='1'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

nvidia-smi
echo "Running from $(pwd)"
echo "Activating virtual environment"
source .depth/bin/activate
export DS_SKIP_CUDA_CHECK=1
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
deepspeed \
--no_local_rank \
--master_port=32057 \
--num_gpus=2 \
train_encoder_decoder.py \
num_gpus=2 \
num_cpus=32 \
data.num_workers=32 \
data.input_length=512 \
data.target_length=8 \
dataset.streaming=false \
precision=bf16 \
model.model_implementation=depth \
deepspeed.use_deepspeed=true \
logging.wandb=true \
model.compile=false \
data.data_collator=depth \
dataset.streaming=false \
optim.total_steps=10_000 \
optim.base_lr=1e-5 \
optim.batch_size=256 \
optim.grad_acc=2 \
optim.warmup_steps=1_000 \
evaluate.every_steps=500 \
logging.every_steps=100 \
checkpoint.every_steps=10_000 \
checkpoint.checkpoint_path=checkpoints/pre_train/from_pretrained/depth/allenai_c4_en/lr_0_0001_linear_bsz_200_shuffle_p_0_5/2024-04-09_19-16/checkpoint-256000 \
mode=ft \
downstream.benchmark_dataset=mnli \
downstream.mnli_sub_dir=matched \
downstream.benchmark_constants=glue \
optim.lr_scheduler=linear \
optim.name=adamw_torch
