#!/bin/bash
#FLUX: --job-name=peachy-gato-6373
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=540000
#FLUX: --urgency=16

nvidia-smi
module load miniconda3
conda activate testenv
which python
python --version
srun /home/u16ak20/.conda/envs/testenv/bin/python main.py --dataset=cifar10 --name=resnet_self_routing --epochs=350
