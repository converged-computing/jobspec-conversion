#!/bin/bash
#FLUX: --job-name=DLmodels
#FLUX: -t=10800
#FLUX: --urgency=16

echo "Download ImageNet pretrained models from pytorch-ensembles"
echo "See https://github.com/bayesgroup/pytorch-ensembles"
command -v module >/dev/null 2>&1 && module load lang/Python
source venv/bin/activate
pip install wldhx.yadisk-direct
cd models/ImageNet/resnet50 || exit
curl -L $(yadisk-direct https://yadi.sk/d/rdk6ylF5mK8ptw?w=1) -o deepens_imagenet.zip
unzip deepens_imagenet.zip
