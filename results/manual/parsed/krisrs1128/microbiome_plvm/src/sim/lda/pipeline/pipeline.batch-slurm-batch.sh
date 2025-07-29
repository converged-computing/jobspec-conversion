#!/bin/bash
#FLUX: --job-name=lda_expers
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

source /home/kriss1/.bash_profile
module load python/3.6.1
cd /scratch/users/kriss1/programming/research/microbiome_plvm/src/sim/lda/pipeline/
python3 pipeline.py LDAExperiment --local-scheduler --workers=5
