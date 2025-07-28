#!/bin/bash
#FLUX: --job-name=tropical_nn
#FLUX: -c=25
#FLUX: --queue=beards
#FLUX: -t=72000
#FLUX: --urgency=16

. /etc/profile
module load lang/python/3.8.11
pip install -r $HOME/TropicalNN/requirements.txt
pip install tensorflow_datasets
pip install easydict
pip install cleverhans
python $HOME/TropicalNN/cleverhans_model_builds.py > $HOME/TropicalNN/batch_print_outputs/run.txt
