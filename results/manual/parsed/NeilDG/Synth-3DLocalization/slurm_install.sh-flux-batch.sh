#!/bin/bash
#FLUX: --job-name=INSTALL
#FLUX: -c=2
#FLUX: --queue=serial
#FLUX: --urgency=16

module load anaconda/3-2021.11
module load cuda/10.1_cudnn-7.6.5
source activate NeilGAN_V2
pip-review --local --auto
pip install -I torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install scikit-learn
pip install scikit-image
pip install visdom
pip install kornia
pip install -I opencv-python==4.5.5.62
pip install --upgrade pillow
pip install gputil
pip install matplotlib
pip install --upgrade --no-cache-dir gdown
pip install PyYAML
