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
--master_port=18402 \
--num_gpus=2 \
train_encoder_decoder.py \
num_gpus=2 \
num_cpus=32 \
data.input_length=272 \
data.target_length=8 \
precision=bf16 \
model.model_implementation=hf_t5 \
deepspeed.use_deepspeed=true \
logging.wandb=true \
model.compile=false \
data.data_collator=custom_t5 \
dataset.streaming=false \
optim.total_steps=2_500 \
optim.base_lr=1e-5 \
optim.batch_size=128 \
optim.grad_acc=1 \
optim.warmup_steps=100 \
evaluate.every_steps=250 \
logging.every_steps=50 \
checkpoint.every_steps=5_000 \
checkpoint.output_dir=./checkpoints \
checkpoint.checkpoint_path=checkpoints/pre_train/from_scratch/hf_t5/c4_en/lr_0_0001_inverse_sqrt_bsz_200_shuffle_p_0_5/2024-03-18_21-25/checkpoint-1000000 \
mode=ft \
downstream.benchmark_dataset=sst2 \
optim.lr_scheduler=linear
