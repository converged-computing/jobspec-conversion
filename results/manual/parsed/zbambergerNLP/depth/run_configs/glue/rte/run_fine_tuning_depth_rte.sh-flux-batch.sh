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
--master_port=12342 \
--num_gpus=4 \
train_encoder_decoder.py \
num_gpus=4 \
num_cpus=32 \
precision=bf16 \
model.model_implementation=depth \
deepspeed.use_deepspeed=true \
logging.wandb=true \
model.compile=false \
data.input_length=256 \
data.target_length=8 \
data.data_collator=depth \
optim.total_steps=4_000 \
optim.base_lr=1e-5 \
optim.batch_size=128 \
optim.grad_acc=1 \
evaluate.every_steps=100 \
logging.every_steps=10 \
checkpoint.every_steps=1000 \
checkpoint.checkpoint_path=checkpoints/depth/from_pretrained/lr_0_001/batch_size_256/2024-02-18_12-45 \
mode=ft \
downstream.benchmark_dataset=rte \
optim.lr_scheduler=linear
