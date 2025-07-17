#!/bin/bash
#FLUX: --job-name=grated-underoos-3814
#FLUX: -n=10
#FLUX: -t=172800
#FLUX: --urgency=16

method="gconet_$1"
size=256
epochs=350
val_last=50
CUDA_VISIBLE_DEVICES=0 python train.py --trainset DUTS_class --size ${size} --ckpt_dir ckpt/${method} --epochs ${epochs} --val_dir tmp4val_${method}
for ((ep=${epochs}-${val_last};ep<${epochs};ep++))
do
pred_dir=/root/datasets/sod/preds/${method}/ep${ep}
rm -rf ${pred_dir}
CUDA_VISIBLE_DEVICES=0 python test.py --pred_dir ${pred_dir} --ckpt ckpt/${method}/ep${ep}.pth --size ${size}
done
cd evaluation
CUDA_VISIBLE_DEVICES=0 python main.py --methods ${method}
python sort_results.py
python select_results.py
cd ..
nvidia-smi
hostname
