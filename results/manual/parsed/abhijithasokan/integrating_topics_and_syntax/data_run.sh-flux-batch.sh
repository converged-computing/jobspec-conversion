#!/bin/bash
#FLUX: --job-name=ITS
#FLUX: --queue=informatik-mind
#FLUX: -t=216000
#FLUX: --urgency=16

module purge
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate integrating_topics_syntax
python preprocess_data.py
conda deactivate
