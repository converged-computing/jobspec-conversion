#!/bin/bash
#FLUX: --job-name=dinosaur-nunchucks-6613
#FLUX: --queue=informatik-mind
#FLUX: --priority=16

module purge
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate integrating_topics_syntax
python preprocess_data.py
conda deactivate
