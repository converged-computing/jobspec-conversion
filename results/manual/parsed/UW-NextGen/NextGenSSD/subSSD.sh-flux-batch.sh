#!/bin/bash
#FLUX: --job-name=fugly-car-3307
#FLUX: --queue=slurm_courtesy
#FLUX: -t=720
#FLUX: --urgency=16

module load usermods
module load user/cuda
source activate ssd
conda install --name ssd numpy --yes
conda install --name ssd tensorflow-gpu --yes
conda install -c anaconda --name ssd keras-gpu --yes
conda install -c anaconda --name ssd matplotlib --yes
conda install -c anaconda --name ssd beautifulsoup4 --yes 
conda install -c anaconda --name ssd scikit-learn --yes
conda install -c anaconda --name ssd Pillow --yes
conda install --name ssd opencv --yes
conda install --name ssd tqdm --yes
python3 train.py 
