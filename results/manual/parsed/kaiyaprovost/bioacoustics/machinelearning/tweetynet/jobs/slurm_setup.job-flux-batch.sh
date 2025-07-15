#!/bin/bash
#FLUX: --job-name=parallelSlurm
#FLUX: -N=2
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load miniconda3
source activate vak-env
conda install pytorch torchvision cudatoolkit -c pytorch
conda install attrs dask joblib matplotlib pandas scipy toml tqdm
pip install vak
pip install tweetynet
