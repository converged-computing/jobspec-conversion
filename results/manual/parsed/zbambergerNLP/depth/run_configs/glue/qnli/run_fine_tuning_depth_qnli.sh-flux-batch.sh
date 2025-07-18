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
--master_port=11800 \
--num_gpus=2 \
train_encoder_decoder.py \
mode=ft \
num_gpus=2 \
num_cpus=32 \
precision=bf16 \
model.model_implementation=depth \
deepspeed.use_deepspeed=true \
logging.wandb=true \
model.compile=false \
data.input_length=512 \
data.target_length=16 \
data.data_collator=depth \
optim.total_steps=10_000 \
optim.warmup_steps=1_000 \
optim.base_lr=1e-4 \
optim.batch_size=64 \
optim.grad_acc=1 \
evaluate.every_steps=500 \
logging.every_steps=50 \
checkpoint.every_steps=12_000 \
checkpoint.checkpoint_path=checkpoints/pre_train/from_scratch/depth/c4_en/lr_0_0001_linear_bsz_200_shuffle_p_0_5/2024-03-11_18-50/checkpoint-2000 \
downstream.benchmark_dataset=qnli \
optim.lr_scheduler=constant_with_warmup
