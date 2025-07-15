#!/bin/bash
#FLUX: --job-name=principled-pre-training
#FLUX: -c=32
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
--master_port=10505 \
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
data.input_length=256 \
data.target_length=16 \
data.data_collator=depth \
optim.total_steps=3_000 \
optim.warmup_steps=300 \
optim.base_lr=1e-5 \
optim.batch_size=16 \
optim.grad_acc=1 \
evaluate.every_steps=100 \
logging.every_steps=10 \
checkpoint.every_steps=10_000 \
checkpoint.checkpoint_path=checkpoints/pre_train/from_scratch/depth/c4_en/lr_0_0001_linear_bsz_200_shuffle_p_0_5/2024-03-11_18-50/checkpoint-1000000 \
downstream.benchmark_dataset=cola \
optim.lr_scheduler=constant_with_warmup
