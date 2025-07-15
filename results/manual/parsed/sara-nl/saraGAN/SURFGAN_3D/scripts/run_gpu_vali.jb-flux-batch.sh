#!/bin/bash
#FLUX: --job-name=crunchy-itch-1929
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'
export PATH='/sw/arch/Debian9/EB_production/2019/software/CUDA/10.0.130/:$PATH'
export TF_USE_CUDNN='0'

module purge
module load 2019
module load cuDNN/7.6.3-CUDA-10.0.130
module load Python/3.6.6-foss-2018b
module load NCCL/2.4.7-CUDA-10.0.130
export OMP_NUM_THREADS=6
export PATH=/sw/arch/Debian9/EB_production/2019/software/CUDA/10.0.130/:$PATH
source ~/.virtualenvs/VALI_TF/bin/activate
cd /home/$USER/projects/saraGAN/SURFGAN_3D/
CONTINUE_PATH=/home/druhe/projects/saraGAN/SURFGAN_3D/runs/pgan2/2020-04-08_08:03:19/model_6_ckpt_3014656
export TF_USE_CUDNN=0
mpirun -np 16 -npernode 4 \
       -bind-to none \
       -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH -x TF_USE_CUDNN \
       -mca pml ob1 -mca btl ^openib \
       python -u main.py pgan2 /nfs/managed_datasets/LIDC-IDRI/npy/average/ '(1, 32, 128, 128)' --starting_phase 6 --ending_phase 6 --latent_dim 512 --horovod  --scratch_path /scratch/$USER --gpu --base_batch_size 128 --network_size s --starting_alpha 0 --loss_fn logistic --gp_weight 1 --d_lr 1e-4 --g_lr 1e-3 --continue_path $CONTINUE_PATH
