#!/bin/bash
#FLUX: --job-name=resnet50_width_barlowtwins
#FLUX: --queue=long
#FLUX: -t=16200
#FLUX: --urgency=16

. /etc/profile
module load anaconda/3
conda activate ffcv
WANDB__SERVICE_WAIT=300
dataset='cifar10'
if [ $dataset = 'stl10' ]
then
    batch_size=256
else
    batch_size=512
fi
SEEDS=3
width=$((1+SLURM_ARRAY_TASK_ID/SEEDS))
seed=$((SLURM_ARRAY_TASK_ID%SEEDS))
lambd=0.00397897
pdim=3072
wandb_group='eigengroup'
model=resnet50proj_width${width}
wandb_projname='modelWidth-scaling'
checkpt_dir=$SCRATCH/fastssl/checkpoints_matteo
python scripts/train_model_widthVary.py --config-file configs/cc_barlow_twins.yaml \
                    --training.lambd=$lambd --training.projector_dim=$pdim \
                    --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                    --training.batch_size=$batch_size --training.model=$model \
                    --training.seed=$seed \
                    --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                    --logging.wandb_project=$wandb_projname
model=resnet50feat_width${width}
trainset=/network/projects/_groups/linclab_users/ffcv/ffcv_datasets/{dataset}
testset=/network/projects/_groups/linclab_users/ffcv/ffcv_datasets/{dataset}
python scripts/train_model_widthVary.py --config-file configs/cc_precache.yaml \
                    --training.lambd=$lambd --training.projector_dim=$pdim \
                    --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                    --training.batch_size=$batch_size --training.model=$model \
                    --training.seed=$seed \
                    --training.train_dataset=${trainset}/train.beton \
                    --training.val_dataset=${testset}/test.beton
python scripts/train_model_widthVary.py --config-file configs/cc_classifier.yaml \
                    --training.lambd=$lambd --training.projector_dim=$pdim \
                    --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                    --training.batch_size=$batch_size --training.model=$model \
                    --training.seed=$seed \
                    --training.train_dataset=${trainset}/train.beton \
                    --training.val_dataset=${testset}/test.beton \
                    --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                    --logging.wandb_project=$wandb_projname
if [ ! -d $checkpt_dir/feats ]
then
    mkdir $checkpt_dir/feats
fi
cp -r $SLURM_TMPDIR/feats/* $checkpt_dir/feats/
wandb_projname='modelWidth-scaling_Noise15'
checkpt_dir=$SCRATCH/fastssl/checkpoints_matteo_Noise15
trainset=/network/projects/_groups/linclab_users/ffcv/ffcv_datasets/{dataset}/Noise_15
testset=/network/projects/_groups/linclab_users/ffcv/ffcv_datasets/{dataset}/Noise_15
python scripts/train_model_widthVary.py --config-file configs/cc_precache.yaml \
                    --training.lambd=$lambd --training.projector_dim=$pdim \
                    --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                    --training.batch_size=$batch_size --training.model=$model \
                    --training.seed=$seed \
                    --training.train_dataset=${trainset}/train.beton \
                    --training.val_dataset=${testset}/test.beton
python scripts/train_model_widthVary.py --config-file configs/cc_classifier.yaml \
                    --training.lambd=$lambd --training.projector_dim=$pdim \
                    --training.dataset=$dataset --training.ckpt_dir=$checkpt_dir \
                    --training.batch_size=$batch_size --training.model=$model \
                    --training.seed=$seed \
                    --training.train_dataset=${trainset}/train.beton \
                    --training.val_dataset=${testset}/test.beton \
                    --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                    --logging.wandb_project=$wandb_projname
if [ ! -d $checkpt_dir/feats ]
then
    mkdir $checkpt_dir/feats
fi
cp -r $SLURM_TMPDIR/feats/* $checkpt_dir/feats/
