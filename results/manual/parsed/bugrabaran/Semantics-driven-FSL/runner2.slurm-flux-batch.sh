#!/bin/bash
#FLUX: --job-name=persnickety-truffle-8050
#FLUX: -t=72000
#FLUX: --priority=16

export PATH='/truba_scratch/eakbas/software/cuda-9.0/bin:$PATH'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/truba_scratch/eakbas/software/cuda-9.0/lib64'

echo CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES
export PATH=/truba_scratch/eakbas/software/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/truba_scratch/eakbas/software/cuda-9.0/lib64
python train_fsl.py  --max_epoch 200 --model_class CombinedProtoNet  --backbone_class Res12 --dataset MiniImageNet --way 5 --eval_way 5 --shot 5 --eval_shot 5 --query 15 --eval_query 15 --balance 0.1 --temperature 32 --lr 0.002 --lr_mul 10 --lr_scheduler step --step_size 40 --gamma 0.5 --gpu $CUDA_VISIBLE_DEVICES --init_weights ./saves/initialization/miniimagenet/Res12-pre.pth --eval_interval 1 --warmup_epoch 0 --num_acc 1 --vis_rate 0.85 --weight_decay 0.0005
