#!/bin/bash
#FLUX: --job-name=creamy-blackbean-6638
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda/3 python/3.7/cuda/11.0/cudnn/8.0/pytorch/1.6.0
conda create --name simpaux
conda activate simpaux
conda install numpy scipy opencv matplotlib scikit-learn scikit-image \
    pandas tqdm imageio pytables h5py gitpython tensorboard fasttext nltk
conda install -c conda-forge ipdb
pip install --no-cache-dir torchmeta future
pip install --no-cache-dir git+https://github.com/epistimio/orion.git@develop
pip install pytorch-warmup
pip install einops
