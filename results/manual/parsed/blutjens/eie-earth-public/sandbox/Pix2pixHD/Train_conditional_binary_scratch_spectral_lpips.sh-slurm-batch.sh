#!/bin/bash
#SBATCH --output=/home/gridsan/lutjens/eie_vision/temp/checkpoint/Pix2pixHD/conditional_binary_spectral/task.sh.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:volta:2

source /etc/profile # eofe: source /etc/profile.d/modules.sh
eval "$(conda shell.bash hook)"
conda deactivate
module load anaconda/2023a-pytorch # eofe: module load anaconda3/2020.11
conda activate eie_vision
echo "path:"
pwd
python src/models/Pix2pixHD/train.py \
--no_lpips_loss --ngf 64 \
--num_D 2 --ndf 64 --n_layers_D 4 \
--serial_batches --no_flip --niter 100 \
--niter_decay 100 \
--checkpoints_dir temp/checkpoint/Pix2pixHD/ \
--name conditional_binary_spectral \
--dataroot /home/gridsan/lutjens/EarthIntelligence_shared/datasets/floods/raw/maxar/xBD_flood \
--dataset_mode physics_aligned_bin \
--no_instance --label_nc 0 \
--input_nc 4 --batchSize 2 --gpu_ids 0,1 \
--continue_train
