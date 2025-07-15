#!/bin/bash
#FLUX: --job-name=verify_simclr
#FLUX: --queue=long
#FLUX: -t=7200
#FLUX: --urgency=16

. /etc/profile
module load anaconda/3
conda activate ffcv_new
temp=0.1
projector_dim=128
dataset='cifar10'
if [ $dataset = 'stl10' ]
then
    batch_size=256
else
    batch_size=512
fi
checkpt_dir=$SCRATCH/fastssl/checkpoints_simclr
train_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/train.beton
val_dpath=$SCRATCH/ffcv/ffcv_datasets/{dataset}/test.beton
model_name=resnet50proj 
python scripts/train_model.py --config-file configs/cc_SimCLR.yaml \
                            --training.temperature=$temp \
                            --training.projector_dim=$projector_dim \
                            --training.model=$model_name \
                            --training.dataset=$dataset \
                            --training.ckpt_dir=$checkpt_dir \
                            --training.batch_size=$batch_size \
			                --training.seed=42 \
                            --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
model_name=resnet50feat
python scripts/train_model.py --config-file configs/cc_precache.yaml \
                            --eval.train_algorithm='SimCLR' \
                            --training.model=$model_name \
                            --training.temperature=$temp \
                            --training.projector_dim=$projector_dim \
                            --training.dataset=$dataset \
                            --training.ckpt_dir=$checkpt_dir \
                            --training.batch_size=$batch_size \
                            --training.seed=42 \
                            --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
python scripts/train_model.py --config-file configs/cc_classifier.yaml \
                            --eval.train_algorithm='SimCLR' \
                            --training.model=$model_name \
                            --training.temperature=$temp \
                            --training.projector_dim=$projector_dim \
                            --training.dataset=$dataset \
                            --training.ckpt_dir=$checkpt_dir \
                            --training.batch_size=$batch_size \
                            --training.seed=42 \
                            --training.train_dataset=$train_dpath --training.val_dataset=$val_dpath
