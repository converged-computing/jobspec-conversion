#!/bin/bash
#FLUX: --job-name=muffled-blackbean-0111
#FLUX: -t=1800
#FLUX: --priority=16

module purge
RUNDIR="$REPOPATH/MLmodels/scripts"
cd $RUNDIR
module load anaconda3/2020.07
conda create -n pytorch python=3.6
source activate pytorch
pip install torch==1.7.1+cu110 -f https://download.pytorch.org/whl/torch_stable.html
pip install requests 
pip install matplotlib 
pip install sklearn 
python vae_train.py &&
python vae_test.py &&
python vae_test_nKL.py &&
python vae_plot.py
