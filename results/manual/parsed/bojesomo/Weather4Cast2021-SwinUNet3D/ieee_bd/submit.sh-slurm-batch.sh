#!/bin/bash
#FLUX: --job-name=ibd4
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load cuda/11.3 miniconda/3 gcc/9.3
conda activate ai4ex
for i in $(lsof /dev/nvidia0 | grep python | awk '{print $2}' | sort -u); do kill -9 $i; done
srun python ieee_bd/main.py --nodes 1 --gpus 4 --blk_type swin2unet3d --stages 4 --patch_size 2 --sf 128 --nb_layers 4  --use_neck --use_all_region --lr 1e-4 --optimizer adam --scheduler plateau --merge_type both  --mlp_ratio 2 --decode_depth 2 --precision 32 --epoch 100 --batch-size 4 --augment_data  --constant_dim --workers 12 --use_static --use_all_products
