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
--master_port=15052 \
--num_gpus=2 \
train_encoder_decoder.py \
mode=ft \
num_gpus=2 \
num_cpus=32 \
precision=bf16 \
model.model_implementation=depth \
model.compile=false \
data.input_length=512 \
data.target_length=32 \
data.num_workers=32 \
data.data_collator=depth \
downstream.benchmark_constants=OfekGlick/DiscoEval \
downstream.benchmark_dataset=DCchat \
dataset.streaming=false \
optim.name=adamw_torch \
optim.base_lr=1e-5 \
optim.batch_size=64 \
optim.total_steps=1_500 \
optim.warmup_steps=100 \
optim.grad_acc=1 \
optim.lr_scheduler=linear \
checkpoint.checkpoint_path=checkpoints/pre_train/from_scratch/depth/c4_en/lr_0_0001_linear_bsz_200_shuffle_p_0_5/2024-03-11_18-50/checkpoint-1000000 \
checkpoint.resume=false \
checkpoint.every_steps=4_000 \
checkpoint.save_total_limit=3 \
logging.every_steps=10 \
logging.wandb=true \
evaluate.every_steps=100
