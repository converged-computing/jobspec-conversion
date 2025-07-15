#!/bin/bash
#FLUX: --job-name=chunky-blackbean-7280
#FLUX: --priority=16

module use /home/druhe/environment-modules-lisa
module load 2020
module load TensorFlow/1.15.0-foss-2019b-Python-3.7.4-10.1.243
cd /home/$USER/projects/saraGAN/SURFGAN_3D/
 mpirun -np 12 -npernode 4 python -u main.py pgan /nfs/managed_datasets/LIDC-IDRI/npy/average/ '(1, 128, 512, 512)' --starting_phase 7 --ending_phase 7 --latent_dim 512 --horovod --starting_alpha 0 --scratch_path /scratch/$USER --gpu --base_batch_size 32 --network_size xs --loss_fn wgan --gp_weight 10 --d_lr 1e-5 --g_lr 1e-5
