#!/bin/bash
#FLUX: --job-name=transfer_base
#FLUX: -c=2
#FLUX: --urgency=16

source ~/.bashrc
conda activate curvature
model='34'      # width of intermediate layer 
batchsize=128
epochs=200
data="cifar100"
log_epoch=5
log_model=20
seed=$((SLURM_ARRAY_TASK_ID % 10 + 400))
lr="0.1"
wd=5e-4
tag='transfer'
lam=0.01
burnin=160
train_modifier="--reg-freq-update 1"
python src/train_reg_transfer.py --seed $seed --model $model --epochs $epochs --lr $lr --wd $wd \
 --data $data --batch-size $batchsize --log-epoch $log_epoch --log-model $log_model --burnin $burnin \
 --lam $lam --reg None --tag $tag $train_modifier
python src/eval_black_box_robustness_contrastive.py \
--model $model --model-type transfer --epochs $epochs \
--seed $seed --lr $lr --wd $wd --nl GELU --data $data \
--batch-size $batchsize --tag $tag \
--log-model $log_model --log-epoch $log_epoch --lam $lam --reg None --burnin $burnin \
--vmin -3 --vmax 3 --perturb-vmin -0.3 --perturb-vmax 0.3 \
--eval-epoch $epochs --eval-sample-size 1000 --reg-freq 1 \
$train_modifier
