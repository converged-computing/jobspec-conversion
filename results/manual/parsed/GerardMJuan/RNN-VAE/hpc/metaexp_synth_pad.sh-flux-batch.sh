#!/bin/bash
#FLUX: --job-name=rnnvae
#FLUX: --queue=high
#FLUX: --urgency=16

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
module load Python
module --ignore-cache load CUDA/10.2.89
module --ignore-cache load cuDNN/7.6.5.32-CUDA-10.2.89
source /homedtic/gmarti/pytorch/bin/activate 
python scripts_mc/metaexp_synth_pad.py
