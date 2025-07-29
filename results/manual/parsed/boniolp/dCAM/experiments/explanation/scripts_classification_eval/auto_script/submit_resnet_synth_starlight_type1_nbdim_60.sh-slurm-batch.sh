#!/bin/bash
#FLUX: --job-name=synth_resnet_synth_starlight_type1_nbdim_60
#FLUX: -c=10
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load pytorch-gpu/py3/1.7.0
set -x
python -u script_exp_dataset.py resnet baseline ../../../data/synthetic/synth_starlight_type1_nbdim_60.pickle 1000 5 8 0.8
