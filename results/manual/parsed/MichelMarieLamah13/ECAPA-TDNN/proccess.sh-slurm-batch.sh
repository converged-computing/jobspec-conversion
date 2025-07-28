#!/bin/bash
#FLUX: --job-name=bp
#FLUX: -t=604800
#FLUX: --urgency=16

source /etc/profile.d/conda.sh
conda activate ecapa_tdnn
conda deactivate
