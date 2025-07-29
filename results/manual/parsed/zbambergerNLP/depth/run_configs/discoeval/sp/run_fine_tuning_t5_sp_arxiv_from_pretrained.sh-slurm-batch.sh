#!/bin/bash
#SBATCH --job-name=principled-pre-training
#SBATCH --account=nlp
#SBATCH --output=fine_tuning_runs/slurm_%N_%j_out.txt
#SBATCH --error=fine_tuning_runs/slurm_%N_%j_err.txt
#SBATCH --mail-user=zachary@campus.technion.ac.il
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:2
#SBATCH --partition=nlp
#SBATCH --nodelist=nlp-ada-1,nlp-ada-2,nlp-a40-1

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
--master_port=16402 \
--num_gpus=2 \
train_encoder_decoder.py \
mode=ft \
num_gpus=2 \
num_cpus=32 \
precision=bf16 \
model.model_implementation=hf_t5 \
model.compile=false \
data.input_length=512 \
data.target_length=32 \
data.num_workers=32 \
data.data_collator=custom_t5 \
downstream.benchmark_constants=OfekGlick/DiscoEval \
downstream.benchmark_dataset=SParxiv \
dataset.streaming=false \
optim.name=adamw_torch \
optim.base_lr=1e-5 \
optim.batch_size=64 \
optim.total_steps=1_500 \
optim.warmup_steps=100 \
optim.grad_acc=1 \
optim.lr_scheduler=linear \
checkpoint.checkpoint_path=checkpoints/pre_train/from_pretrained/hf_t5/allenai/c4_en/lr_0_0001_inverse_sqrt_bsz_200_shuffle_p_0_5/2024-04-03_20-31/checkpoint-256000 \
checkpoint.resume=false \
checkpoint.every_steps=4_000 \
checkpoint.save_total_limit=3 \
logging.every_steps=10 \
logging.wandb=true \
evaluate.every_steps=100
