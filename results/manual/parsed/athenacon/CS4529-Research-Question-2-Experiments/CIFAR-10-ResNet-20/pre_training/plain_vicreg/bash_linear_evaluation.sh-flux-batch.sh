#!/bin/bash
#FLUX: --job-name=outstanding-bits-9926
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=540000
#FLUX: --urgency=16

nvidia-smi
module load miniconda3
conda activate testenv
which python
python --version
srun /home/u16ak20/.conda/envs/testenv/bin/python main_vicreg.py --exp-dir "pre-training/" --arch resnet20 --epochs 1000 --batch-size 128 --base-lr 0.2 --data-dir "cifar10"
