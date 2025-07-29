#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --partition=gpu-normal

export CUDA_VISIBLE_DEVICES='0,1,2,3'

export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -m torch.distributed.run --nproc_per_node=4 train_retrieval.py --config ./configs/retrieval_flickr_small6.yaml --output_dir output/retrieval_flickr
