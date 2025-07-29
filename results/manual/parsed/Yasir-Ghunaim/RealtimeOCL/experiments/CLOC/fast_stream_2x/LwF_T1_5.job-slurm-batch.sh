#!/bin/bash
#SBATCH --job-name=LwFT1_5
#SBATCH --output=/path/to/output.%J.out
#SBATCH --error=/path/to/error.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=200G
#SBATCH --time=2-02:00:00

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cloc' \
--batch_size 128 \
--lr 0.005 \
--lr_type 'constant' \
--batch_delay 1.5 \
--gradient_steps 1 \
--output_dir '/path/to/tensorboard/output' \
--workers 12 \
--method 'LwF' \
--LwF_warmup 0.05 \
--LwF_update_freq 1000 \
--seed 123 \
--dataset_root '/path/to/CLOC/release/' \
--size_replay_buffer 40000 \
--pretrained
