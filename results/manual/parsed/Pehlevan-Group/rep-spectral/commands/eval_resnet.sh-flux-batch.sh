#!/bin/bash
#FLUX: --job-name=hello-bike-7918
#FLUX: --priority=16

model='34'      # width of intermediate layer 
epochs="200"    # epochs 
lr="0.01"       # learning rate 
nl="GELU"
weight_decay="0"  # ! weight decay 
data="cifar10"
batchsize="1024"
log_epoch=5
log_model=20
tag='resnet_gelu'
lam="0.1"
reg="None"
burnin=160
seed=500
for seed in "40" "50" "60" "70" "80"; do
    python src/eval_black_box_robustness.py --model $model --epochs $epochs \
    --seed $seed --lr $lr --nl $nl --wd $weight_decay --data $data \
    --batch-size $batchsize --tag $tag \
    --log-model $log_model --log-epoch $log_epoch --lam $lam --reg $reg --burnin $burnin \
    --vmin -3 --vmax 3 --perturb-vmin -0.3 --perturb-vmax 0.3 \
    --eval-epoch $epochs --eval-sample-size 1000 --reg-freq 1
done
