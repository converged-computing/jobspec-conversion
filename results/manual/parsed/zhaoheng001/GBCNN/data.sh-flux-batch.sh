#!/bin/bash
#FLUX: --job-name=milky-lizard-2664
#FLUX: --urgency=16

hostname
module add cudatoolkit/11.6
module add torchvision/0.15.2-foss-2022a-CUDA-11.7.0
module add PyTorch/2.0.1-foss-2022a-CUDA-11.7.0
module add OpenCV/4.5.3-fosscuda-2021a-Python-3.8.2
module add opencv-python
module add matplotlib
module add scikit-learn
module add tqdm
python places2_train.py
