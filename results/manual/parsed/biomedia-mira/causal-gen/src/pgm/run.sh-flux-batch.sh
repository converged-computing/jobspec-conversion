#!/bin/bash
#FLUX: --job-name=fuzzy-peanut-butter-3710
#FLUX: -c=4
#FLUX: --queue=gpus
#FLUX: --urgency=16

model_name='ukbb192_beta5_dgauss'
exp_name=$model_name'-dscm'
parents='m_b_v_s'
mkdir -p "../../checkpoints/$parents/$exp_name"
sbatch <<EOT
nvidia-smi
. /anaconda3/etc/profile.d/conda.sh
conda activate torch
srun python train_cf.py \
    --data_dir='../ukbb' \
    --exp_name=$exp_name \
    --pgm_path='../../checkpoints/sup_pgm/checkpoint.pt' \
    --predictor_path='../../checkpoints/sup_aux_prob/checkpoint.pt' \
    --vae_path='../../checkpoints/$parents/$model_name/checkpoint.pt' \
    --lr=1e-4 \
    --bs=32 \
    --wd=0.1 \
    --eval_freq=1 \
    --plot_freq=500 \
    --do_pa=None \
    --alpha=0.1 \
    --seed=7
EOT
