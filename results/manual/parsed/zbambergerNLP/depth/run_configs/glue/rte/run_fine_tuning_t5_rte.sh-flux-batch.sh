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
--master_port=12345 \
--num_gpus=2 \
train_encoder_decoder.py \
mode=ft \
num_gpus=2 \
num_cpus=32 \
precision=bf16 \
model.model_implementation=hf_t5 \
model.compile=false \
data.input_length=256 \
data.target_length=8 \
data.num_workers=32 \
data.data_collator=custom_t5 \
downstream.benchmark_constants=glue \
downstream.benchmark_dataset=rte \
dataset.streaming=false \
optim.name=adamw_torch \
optim.base_lr=5e-5 \
optim.batch_size=32 \
optim.total_steps=3_000 \
optim.warmup_steps=100 \
optim.grad_acc=1 \
optim.lr_scheduler=linear \
checkpoint.resume=false \
checkpoint.every_steps=5_000 \
checkpoint.save_total_limit=3 \
logging.every_steps=50 \
logging.wandb=true \
evaluate.every_steps=200
