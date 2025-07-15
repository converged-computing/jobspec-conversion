#!/bin/bash
#FLUX: --job-name=detectron2
#FLUX: --queue=gpu
#FLUX: --priority=16

module load broadwell/gcc/9.2.0
module load python/3.8.6
module load cuda/11.3.1
pip3 install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
python -m pip install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu113/torch1.10/index.html
python pip_detectron2_training_hpc.py
