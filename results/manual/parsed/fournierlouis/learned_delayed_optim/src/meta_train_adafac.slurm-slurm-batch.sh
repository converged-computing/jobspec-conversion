#!/bin/bash
#SBATCH --job-name=train_adafac
#SBATCH --account=wjm@a100
#SBATCH --output=gpu_adafac_meta%j.out
#SBATCH --error=gpu_adafac_meta%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=12:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

module purge
cd /gpfswork/rech/bao/unl88dr/learned_delayed_optim/
module load cpuarch/amd
module load cudnn/10.1-v7.5.1.10
module load python/3.11.5
source venv3/bin/activate
wandb offline
set -x
delay=${1}
python3.11 src/main.py \
    --config config/meta_train/meta_train_delay_adafac32_image-mlp-fmst_schedule_3e-3_10000_d3.py \
    --num_local_steps 4 \
    --num_grads 8 \
    --local_learning_rate 0.5 \
    --delay ${delay} \
    --tfds_data_dir $STORE/tf_datasets\
    --wandb_dir $STORE/jax_wandb
