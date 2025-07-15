#!/bin/bash
#FLUX: --job-name=GPU-Example
#FLUX: -c=2
#FLUX: -t=86399
#FLUX: --urgency=16

module load anaconda/anaconda3
source /apps/anaconda/anaconda3/etc/profile.d/conda.sh
source activate vit_ass
python3.9 --version
pip --version
pip install -r /home/cap6411.student19/Ass2/CAP6411_Ass2/requirements_pip.txt
python3 generate_outputs.py --model_type vit_h_14 --dataset imagenet --image_folder models/images/imagenet --env newton
python3 generate_outputs.py --model_type vit_h_14 --dataset imagenet_real --image_folder models/images/imagenet_real --env newton
python3 generate_outputs.py --model_type vit_h_14 --dataset flowers102 --image_folder models/images/flowers102 --env newton --pretrained_dir models/checkpoints/flowers102_vit_h_14.bin
python3 generate_outputs.py --model_type vit_h_14 --dataset oxford_iiit --image_folder models/images/oxford_iiit --env newton --pretrained_dir models/checkpoints/oxford_iiit_vit_h_14.bin
python3 generate_outputs.py --model_type vit_h_14 --dataset cifar10 --image_folder models/images/cifar10 --env newton --pretrained_dir models/checkpoints/cifar10_vit_h_14.bin
python3 generate_outputs.py --model_type vit_h_14 --dataset cifar100 --image_folder models/images/cifar100 --env newton --pretrained_dir models/checkpoints/cifar100_vit_h_14.bin
