#!/bin/bash
#FLUX: --job-name=grated-poo-5007
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

export CUDA_VISIBLE_DEVICES=0,1,2,3
srun python -m torch.distributed.run --nproc_per_node=4 train_retrieval.py --config ./configs/retrieval_flickr_small6.yaml --output_dir output/retrieval_flickr
