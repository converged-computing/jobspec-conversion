#!/bin/bash
#FLUX: --job-name=exp_stl10_run_fastssl_design_hparam_sweep
#FLUX: --queue=long
#FLUX: -t=43200
#FLUX: --priority=16

. /etc/profile
module load anaconda/3
conda activate ffcv
lamda_arr=(1e-5 4e-5 1e-4 4e-4)
proj_arr=(1024 2048)
checkpt_dir='checkpoints_design_hparams_stl10'
lenL=${#lamda_arr[@]}
lidx=$((SLURM_ARRAY_TASK_ID%lenL))
pidx=$((SLURM_ARRAY_TASK_ID/lenL))
dataset='stl10'
batch_size=256
python scripts/train_model.py --config-file configs/cc_barlow_twins.yaml --training.lambd=${lamda_arr[$lidx]} --training.projector_dim=${proj_arr[$pidx]} --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.batch_size=$batch_size
dataset='stl10'
python scripts/train_model.py --config-file configs/cc_classifier.yaml --training.lambd=${lamda_arr[$lidx]} --training.projector_dim=${proj_arr[$pidx]} --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=1
python scripts/train_model.py --config-file configs/cc_classifier.yaml --training.lambd=${lamda_arr[$lidx]} --training.projector_dim=${proj_arr[$pidx]} --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=2
dataset='cifar10'
python scripts/train_model.py --config-file configs/cc_classifier.yaml --training.lambd=${lamda_arr[$lidx]} --training.projector_dim=${proj_arr[$pidx]} --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=1
python scripts/train_model.py --config-file configs/cc_classifier.yaml --training.lambd=${lamda_arr[$lidx]} --training.projector_dim=${proj_arr[$pidx]} --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir --training.seed=2
