#!/bin/bash
#SBATCH --output=../checkpoints/$parents/$exp_name/slurm.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:teslat4:1
#SBATCH --mem=32gb
#SBATCH --partition=gpus
#SBATCH --constraint=ntasks-per-node=1

exp_name='ukbb192_beta5_dgauss'
parents='m_b_v_s'
mkdir -p "../checkpoints/$parents/$exp_name"
sbatch <<EOT
nvidia-smi
. /anaconda3/etc/profile.d/conda.sh
conda activate torch
srun python main.py \
    --exp_name=$exp_name \
    --data_dir=/data2/ukbb \
    --hps ukbb192 \
    --parents_x mri_seq brain_volume ventricle_volume sex \
    --context_dim=4 \
    --concat_pa \
    --lr=0.001 \
    --bs=32 \
    --wd=0.05 \
    --beta=5 \
    --x_like=diag_dgauss \
    --z_max_res=96 \
    --eval_freq=4
EOT
