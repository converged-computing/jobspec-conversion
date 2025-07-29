#!/bin/bash
#SBATCH --job-name=pre_training_job
#SBATCH --account=nlp
#SBATCH --output=pre_training_runs/slurm_%A_%a_%N_out.txt
#SBATCH --error=pre_training_runs/slurm_%A_%a_%N_err.txt
#SBATCH --mail-user=zachary@campus.technion.ac.il
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --gres=gpu:6
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=nlp-ada-2

export GPUS_PER_NODE='6'

nvidia-smi
export GPUS_PER_NODE=6
accelerate launch -m \
--mixed_precision bf16 \
--num_cpu_threads_per_process 64 \
--num_processes 6 \
nanoT5.main \
optim.name=adamwscale \
optim.lr_scheduler=cosine \
model.compile=true \
num_gpus=6 \
num_cpus=64 \
data.num_workers=64
