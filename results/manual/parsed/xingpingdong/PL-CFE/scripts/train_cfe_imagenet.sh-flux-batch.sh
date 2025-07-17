#!/bin/bash
#FLUX: --job-name=muffled-dog-4106
#FLUX: -n=4
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

export PATH='/home/xd1/miniconda3/bin:$PATH'

nvidia-smi
export PATH="/home/xd1/miniconda3/bin:$PATH"
source /home/xd1/miniconda3/etc/profile.d/conda.sh
conda activate PL-CFE
save=imagenet
dir_imagenet=/home/xd1/datasets/imagenet
mkdir $save
cd $save
python -c 'import torch; print("GPU available? {}. Got {} GPUs.".format
(torch.cuda.is_available(),torch.cuda.device_count()))'
python ../../main_cfe_im84.py \
  -a resnet50 \
  --lr 0.03 \
  --batch-size 256 \
  --mlp --cfe-t 0.2 --aug-plus --cos \
  --dist-url 'tcp://localhost:10001' --multiprocessing-distributed --world-size 1 --rank 0 \
  ${dir_imagenet}
