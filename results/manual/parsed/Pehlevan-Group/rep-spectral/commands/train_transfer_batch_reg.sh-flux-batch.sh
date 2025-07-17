#!/bin/bash
#FLUX: --job-name=transfer_base
#FLUX: -c=2
#FLUX: -t=720
#FLUX: --urgency=16

source ~/.bashrc
conda activate curvature
model='34'      # width of intermediate layer 
batchsize=128
epochs=200
data="cifar100"
log_epoch=1
log_model=30
seed=$((SLURM_ARRAY_TASK_ID % 10 + 400))
lr="0.1"
wd=5e-4
tag='transfer'
if [ $(((SLURM_ARRAY_TASK_ID / 10) % 3)) == 0 ]; then
    lam=0.01
elif [ $(((SLURM_ARRAY_TASK_ID / 10) % 3)) == 1 ]; then
    lam=0.001
else
    lam=0.0001
fi 
if [ $(((SLURM_ARRAY_TASK_ID / 30) % 2)) == 0 ]; then
    burnin=160
else 
    burnin=120
fi
if [ $(((SLURM_ARRAY_TASK_ID / 60) % 2)) == 0 ]; then
    train_modifier="--reg-freq-update 5"
else 
    train_modifier="--reg-freq-update 20"
fi
python src/train_reg_transfer.py --seed $seed --model $model --epochs $epochs --lr $lr --wd $wd \
 --data $data --batch-size $batchsize --log-epoch $log_epoch --log-model $log_model --burnin $burnin \
 --lam $lam --reg eig-ub --tag $tag $train_modifier
