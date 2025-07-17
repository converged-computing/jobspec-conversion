#!/bin/bash
#FLUX: --job-name=goodbye-snack-8836
#FLUX: -t=10800
#FLUX: --urgency=16

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
python dae_train.py &&
python dae_test.py &&
python dae_test_nKL.py &&
python dae_plot.py
