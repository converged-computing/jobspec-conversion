#!/bin/bash
#SBATCH --job-name=2varGAN
#SBATCH --account=fc_bsclab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=16:00:00

module load ml/tensorflow/1.12.0-py36
cd Structure-in-GAN
nohup python3 backup.py '/global/scratch/users/thomaslu/train_dir2' 60 &
python3 ./train_ciwgan.py train '/global/scratch/users/thomaslu/train_dir2/' --data_dir './2_word_concat/generated_data/' --data_slice_len 32768 --num_categ 6 --data_first_slice --data_pad_end --data_fast_wav
