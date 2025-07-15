#!/bin/bash
#FLUX: --job-name=task_1
#FLUX: -c=24
#FLUX: --queue=deeplearn
#FLUX: -t=180000
#FLUX: --priority=16

echo "Loading required modules"
module load fosscuda/2020b
module load torchvision/0.10.0-python-3.8.6-pytorch-1.9.0
echo "Install libs" 
pip3 install statsmodels
pip3 install --user tqdm
pip3 install --user scikit-learn
pip3 install --user matplotlib
echo "Good to go!"
cd opacus/examples
python3 automator.py
