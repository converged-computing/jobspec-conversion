#!/bin/bash
#FLUX: --job-name=linear_RN50
#FLUX: -c=18
#FLUX: --urgency=16

source /home/sliu/miniconda3/etc/profile.d/conda.sh
source activate slak
python -m torch.distributed.launch --nproc_per_node=1 --master_port=22345  eval_linear.py --data_path /projects/2/managed_datasets/imagenet/ \
--arch resnet50 \
--pretrained_weights /projects/0/prjste21060/projects/dino/resnet50/checkpoint.pth \
--output_dir /projects/0/prjste21060/projects/dino/resnet50/linear/ --checkpoint_key teacher
source deactivate
