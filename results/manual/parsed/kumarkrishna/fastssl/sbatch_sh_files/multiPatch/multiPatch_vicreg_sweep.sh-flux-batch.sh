#!/bin/bash
#FLUX: --job-name=multiPatch_vicreg_sweep
#FLUX: --queue=long
#FLUX: -t=10800
#FLUX: --priority=16

. /etc/profile
module load anaconda/3
conda activate ffcv_new
lambd_arr=(1.0 2.0 5.0 10.0 15.0 25.0 40.0 50.0 75.0 100.0)
pdim_arr=(256)
augs_arr=(4)
dataset='cifar10'
if [ $dataset = 'stl10' ]
then
    batch_size=64
else
    batch_size=128
fi
len1=${#lambd_arr[@]}
len2=${#pdim_arr[@]}
len12=$((len1*len2))
aidx=$((SLURM_ARRAY_TASK_ID/len12))
lpidx=$((SLURM_ARRAY_TASK_ID%len12))
pidx=$((lpidx/len1))
lidx=$((lpidx%len1))
lambd=${lambd_arr[$lidx]}
mu=${lambd_arr[$lidx]}
pdim=${pdim_arr[$pidx]}
augs=${augs_arr[$aidx]}
wandb_group='blake-richards'
wandb_projname='multiPatch-VICReg-sweep-ep100'
model=resnet50proj
checkpt_dir=$SCRATCH/fastssl/checkpoints_vicreg_mp
train_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/train.beton
val_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/test.beton
python scripts/train_model_multiPatch.py --config-file configs/cc_VICReg.yaml \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim \
                --training.num_augmentations=$augs \
                --training.epochs=100 --training.log_interval=100 \
                --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.model=$model \
                --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                --logging.wandb_project=$wandb_projname \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
model=resnet50feat
python scripts/train_model_multiPatch.py --config-file configs/cc_precache.yaml \
                --eval.train_algorithm='VICReg' \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim \
                --eval.num_augmentations_pretrain=$augs --eval.epoch=100 \
                --training.num_augmentations=16 \
                --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.model=$model \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
python scripts/train_model_multiPatch.py --config-file configs/cc_classifier.yaml \
                --eval.train_algorithm='VICReg' \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim \
                --eval.num_augmentations_pretrain=$augs --eval.epoch=100 \
                --training.num_augmentations=16 \
                --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.model=$model \
                --training.seed=42 \
                --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                --logging.wandb_project=$wandb_projname \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
