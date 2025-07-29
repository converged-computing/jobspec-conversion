#!/bin/bash
#SBATCH --job-name=MIRT0
#SBATCH --output=/path/to/output.%J.out
#SBATCH --error=/path/to/error.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu
#SBATCH --mem=200G
#SBATCH --time=01:00:00
#SBATCH --partition=batch

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cifar100' \
--batch_size 10 \
--lr 0.01 \
--lr_type 'constant' \
--batch_delay 0 \
--gradient_steps 1 \
--output_dir '/path/to/tensorboard/output' \
--workers 4 \
--method 'MIR' \
--seed 123 \
--size_replay_buffer 100
