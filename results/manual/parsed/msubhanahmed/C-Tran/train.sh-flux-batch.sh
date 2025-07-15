#!/bin/bash
#FLUX: --job-name=train_ctran_bcepoly2
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load gcc/9.3
module load python/3.9.6
module load miniconda/3
module load cuda/11.3
pip install -q timm
pip install -q einops
pip install -q nltk
pip install -q pillow
pip install -q numpy
pip install -q torch==1.8.0+cu111 torchvision==0.9.0+cu111 torchaudio==0.8.0 -f https://download.pytorch.org/whl/torch_stable.html
pip install -qU scikit-learn
pip install -q pandas
pip install -q tensorboard
pip install -qU albumentations
pip install -q scikit-multilearn
pip install -qU iterative-stratification
