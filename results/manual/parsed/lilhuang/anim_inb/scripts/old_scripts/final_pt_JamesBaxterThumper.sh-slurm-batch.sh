#!/bin/bash
#SBATCH --job-name=JamesBaxterThumper_seq
#SBATCH --output=JamesBaxterThumper_seq.log
#SBATCH --error=JamesBaxterThumper_seq.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtxa6000:2
#SBATCH --mem=64gb
#SBATCH --time=1-00:00:00
#SBATCH --qos=high

cd /fs/cfar-projects/anim_inb
source env3-9-5/bin/activate
module unload cuda
module load cuda/11.3.1 cudnn/v8.2.1 ffmpeg gcc
python train_anime_sequence_2_stream.py configs/seg_config/config_final_seq_JamesBaxterThumper.py
