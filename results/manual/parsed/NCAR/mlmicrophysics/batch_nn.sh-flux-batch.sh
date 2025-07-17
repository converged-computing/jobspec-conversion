#!/bin/bash
#FLUX: --job-name=micro_nn
#FLUX: -t=82800
#FLUX: --urgency=16

export PATH='/glade/u/home/ggantos/ncar_20200417/bin:$PATH'

module load gnu/8.3.0 openmpi/3.1.4 python/3.7.5 cuda/10.1
ncar_pylib ncar_20200417
export PATH="/glade/u/home/ggantos/ncar_20200417/bin:$PATH"
pip install /glade/work/ggantos/mlmicrophysics/.
python scripts/train_mp_neural_nets.py config/cesm_sd_full_train_nn.yml
