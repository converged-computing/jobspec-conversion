#!/bin/bash
#SBATCH --job-name=ERpp_GSS
#SBATCH --output=/path/to/output.%J.out
#SBATCH --error=/path/to/error.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:2
#SBATCH --mem=300G
#SBATCH --time=4-04:00:00
#SBATCH --partition=batch

module purge
module load gcc/11.1.0
conda activate realtime_ocl
cd ../../..
python main.py \
--dataset 'cloc' \
--batch_size 128 \
--lr 0.005 \
--lr_type 'constant' \
--batch_delay 0 \
--gradient_steps 6 \
--output_dir '/path/to/tensorboard/output' \
--workers 12 \
--method 'ER' \
--seed 123 \
--dataset_root '/path/to/CLOC/release/' \
--size_replay_buffer 40000 \
--pretrained
