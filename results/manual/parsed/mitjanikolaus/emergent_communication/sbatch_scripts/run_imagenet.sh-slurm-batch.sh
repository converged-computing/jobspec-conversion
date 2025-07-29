#!/bin/bash
#SBATCH --job-name=imagenet
#SBATCH --account=eqb@a100
#SBATCH --output=out/imagenet_%j.out
#SBATCH --error=out/imagenet_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

module purge
module load cpuarch/amd
module load python
conda activate emergent_communication
set -x
num_senders=1
num_receivers=1
vocab_size=20
vocab_size_feedback=20
max_len=5
patience=100
training_time="00:20:00:00"
job_time="22:00:00"
entropy_coeff=0.01
seed=3
baseline_args="--batch-size 100 --precision=16 --accelerator=gpu --devices=1 --sender-entropy-coeff=$entropy_coeff --receiver-entropy-coeff=$entropy_coeff --seed=$seed --num-senders=$num_senders --num-receivers=$num_receivers --patience=$patience --vocab-size=$vocab_size --max-len=$max_len --val_check_interval 400 --limit_val_batches 100 --num-workers 10 --max_time=$training_time --sender-layer-norm --receiver-layer-norm --imagenet --discrimination-num-objects 2 --sender-embed-dim 10 --receiver-embed-dim 10 --hard-distractors"
fb_args="$baseline_args --feedback --vocab-size-feedback=$vocab_size_feedback"
python -u train.py $fb_args
