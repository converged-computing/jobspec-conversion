#!/bin/bash
#FLUX: --job-name=red-earthworm-2332
#FLUX: --queue=informatik-mind
#FLUX: --urgency=16

module purge
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate integrating_topics_syntax
python preprocess_data.py
conda deactivate
