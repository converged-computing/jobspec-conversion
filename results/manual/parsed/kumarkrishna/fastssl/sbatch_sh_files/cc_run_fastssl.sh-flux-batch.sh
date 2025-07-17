#!/bin/bash
#FLUX: --job-name=exp_run_fastssl
#FLUX: --queue=long
#FLUX: -t=14400
#FLUX: --urgency=16

export LD_PRELOAD='~/Projects/SSL_alpha/fastssl/configs/hack.so 	# Olexa's hack to avoid INTERNAL ASSERT ERROR on Pytorch 1.10'
export MKL_THREADING_LAYER='TBB'

. /etc/profile
module load anaconda/3
conda activate ffcv
export LD_PRELOAD=~/Projects/SSL_alpha/fastssl/configs/hack.so 	# Olexa's hack to avoid INTERNAL ASSERT ERROR on Pytorch 1.10
export MKL_THREADING_LAYER=TBB
lamda=0.01
proj_dim=1024
checkpt_dir='checkpoints'
dataset='stl10'
batch_size=256
python scripts/train_model.py --config-file configs/cc_barlow_twins.yaml --training.lambd=$lamda --training.projector_dim=$proj_dim --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.batch_size=$batch_size
python scripts/train_model.py --config-file configs/cc_classifier.yaml --training.lambd=$lamda --training.projector_dim=$proj_dim --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=1 --training.batch_size=$batch_size
python scripts/train_model.py --config-file configs/cc_classifier.yaml --training.lambd=$lamda --training.projector_dim=$proj_dim --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=2 --training.batch_size=$batch_size
