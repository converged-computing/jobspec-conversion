#!/bin/bash
#FLUX: --job-name=resnet50_barlowtwins
#FLUX: --queue=long
#FLUX: -t=14400
#FLUX: --urgency=16

. /etc/profile
module load anaconda/3
conda activate ffcv_new
lambd_arr=(0.0001 0.0002 0.0004 0.0008 0.001 0.002 0.004 0.006 0.01 0.02)
pdim_arr=(256 512 768 1024 1536 2048 2304 2560 3072 4096 6144 8192)
dataset='cifar10'
if [ $dataset = 'stl10' ]
then
    batch_size=256
else
    batch_size=512
fi
lenL=${#lambd_arr[@]}
pidx=$((SLURM_ARRAY_TASK_ID/lenL))
lidx=$((SLURM_ARRAY_TASK_ID%lenL))
lambd=${lambd_arr[$lidx]}
pdim=${pdim_arr[$pidx]}
wandb_group='blake-richards'
wandb_projname='BarlowTwins-resnet50-hparam'
width=64
model=resnet50proj_width${width}
checkpt_dir=$SCRATCH/fastssl/checkpoints_matteo
python scripts/train_model_widthVary.py --config-file configs/cc_barlow_twins.yaml \
                --training.lambd=$lambd --training.projector_dim=$pdim \
                --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.model=$model \
                --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                --logging.wandb_project=$wandb_projname
model=resnet50feat_width${width}
python scripts/train_model_widthVary.py --config-file configs/cc_precache.yaml \
                --training.lambd=$lambd --training.projector_dim=$pdim \
                --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.model=$model
python scripts/train_model_widthVary.py --config-file configs/cc_classifier.yaml \
                --training.lambd=$lambd --training.projector_dim=$pdim \
                --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.model=$model \
                --training.seed=42 \
                --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                --logging.wandb_project=$wandb_projname
