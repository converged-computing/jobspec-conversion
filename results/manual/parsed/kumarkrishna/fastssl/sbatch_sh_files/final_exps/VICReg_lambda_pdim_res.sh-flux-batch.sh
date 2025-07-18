#!/bin/bash
#FLUX: --job-name=resnet50_vicreg_lambda_pdim
#FLUX: --queue=long
#FLUX: -t=9000
#FLUX: --urgency=16

. /etc/profile
module load anaconda/3
conda activate ffcv_new
WANDB__SERVICE_WAIT=300
lambd_arr=(750.0 750.0 750.0 750.0 750.0 750.0 750.0 750.0)
pdim_arr=(64 128 256 512 1024 2048 4096 8192)
dataset='cifar10'
if [ $dataset = 'stl10' ]
then
    batch_size=256
else
    batch_size=512
fi
lenL=${#lambd_arr[@]}
sidx=$((SLURM_ARRAY_TASK_ID/lenL))
cfgidx=$((SLURM_ARRAY_TASK_ID%lenL))
lambd=${lambd_arr[$cfgidx]}
mu=${lambd_arr[$cfgidx]}
pdim=${pdim_arr[$cfgidx]}
wandb_group='eigengroup'
wandb_projname='VICReg-pdim-ortho-result'
model=resnet50proj
checkpt_dir=$SCRATCH/fastssl/checkpoints_VICReg_cifar10
train_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/train.beton
val_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/test.beton
python scripts/train_model.py --config-file configs/cc_VICReg.yaml \
                --training.model=$model --training.dataset=$dataset \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim  --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.seed=$sidx \
                --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                --logging.wandb_project=$wandb_projname \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
model=resnet50feat
python scripts/train_model.py --config-file configs/cc_precache.yaml \
                --eval.train_algorithm='VICReg' \
                --training.model=$model --training.dataset=$dataset \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim  --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.seed=$sidx \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
python scripts/train_model.py --config-file configs/cc_classifier.yaml \
                --eval.train_algorithm='VICReg' \
                --training.model=$model --training.dataset=$dataset \
                --training.lambd=$lambd --training.mu=$mu \
                --training.projector_dim=$pdim  --training.ckpt_dir=$checkpt_dir \
                --training.batch_size=$batch_size --training.seed=$sidx \
                --logging.use_wandb=True --logging.wandb_group=$wandb_group \
                --logging.wandb_project=$wandb_projname \
                --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
