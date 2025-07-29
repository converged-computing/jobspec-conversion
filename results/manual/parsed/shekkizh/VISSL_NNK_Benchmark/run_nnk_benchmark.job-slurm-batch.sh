#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:2
#SBATCH --mem=0
#SBATCH --time=00:25:00
#SBATCH --partition=gpu

module load gcc
module load python/3.7.6
module load cuda/10.1.243
module load cudnn/8.0.2-10.1
source ~/vissl/bin/activate
python nnk_benchmark.py --config imagenet1k_resnet50_mocov2_800ep.yaml  --model_url /scratch/shekkizh/torch_hub/checkpoints/moco_v2_800ep_pretrain.pth.tar --top_k 50 --noextract_features
