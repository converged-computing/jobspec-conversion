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
--master_port=12255 \
--num_gpus=2 \
train_encoder_decoder.py \
mode=ft \
num_gpus=2 \
num_cpus=32 \
precision=bf16 \
model.model_implementation=hf_t5 \
model.compile=false \
data.input_length=512 \
data.target_length=8 \
data.num_workers=32 \
data.data_collator=custom_t5 \
downstream.benchmark_constants=glue \
downstream.benchmark_dataset=mnli \
downstream.mnli_sub_dir=mismatched \
dataset.streaming=false \
optim.name=adamw_torch \
optim.base_lr=1e-5 \
optim.batch_size=200 \
optim.total_steps=12_000 \
optim.warmup_steps=1_000 \
optim.grad_acc=2 \
optim.lr_scheduler=linear \
checkpoint.resume=false \
checkpoint.every_steps=12_000 \
checkpoint.save_total_limit=3 \
checkpoint.checkpoint_path=checkpoints/pre_train/from_pretrained/hf_t5/allenai/c4_en/lr_0_0001_inverse_sqrt_bsz_200_shuffle_p_0_5/2024-04-03_20-31/checkpoint-2000 \
logging.every_steps=100 \
logging.wandb=true \
evaluate.every_steps=500
