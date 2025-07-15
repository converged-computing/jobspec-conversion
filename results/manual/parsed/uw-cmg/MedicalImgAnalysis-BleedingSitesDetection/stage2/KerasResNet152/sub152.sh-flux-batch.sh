#!/bin/bash
#FLUX: --job-name=dirty-malarkey-7001
#FLUX: --priority=16

module load usermods
module load user/cuda
source activate resnet 
pip install tensorflow-gpu
pip install keras
conda install --name resnet matplotlib 
conda install --name resnet -c anaconda scikit-learn  
conda install --name resnet numpy 
conda install --name resnet scipy 
conda install --name resnet pillow
conda install --name resnet scikit-image
python Focus152.py 
