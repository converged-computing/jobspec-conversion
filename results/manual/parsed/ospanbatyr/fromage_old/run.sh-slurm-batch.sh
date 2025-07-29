#!/bin/bash
#SBATCH --job-name=JupiterNotebook
#SBATCH --account=ai
#SBATCH --output=test_%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla_t4:1
#SBATCH --mem=60G
#SBATCH --time=1-12:00:00
#SBATCH --partition=ai
#SBATCH --qos=ai
#SBATCH --constraint=ntasks-per-node=2

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
