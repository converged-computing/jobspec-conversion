#!/bin/bash
#FLUX: --job-name=JupiterNotebook
#FLUX: --queue=ai
#FLUX: -t=129600
#FLUX: --priority=16

echo "======================="
echo "Loading Anaconda Module..."
module load cuda/10.2
module load cudnn/8.1.1/cuda-10.2
echo "======================="
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
python -u main.py --dist-backend 'nccl' --world-size 1 --rank 0 --dataset=MIMIC  --val-dataset=MIMIC --opt-version='microsoft/biogpt' --visual-model='microsoft/swin-tiny-patch4-window7-224' --exp_name='fromage_exp' --log-base-dir='runs/' --batch-size=16  --val-batch-size=16  --learning-rate=0.0003 --precision='fp32' --print-freq=100 --workers=2 --image-dir='/datasets/mimic/physionet.org/files/mimic-cxr/2.0.0/files' --max-len=100 --epochs 30
