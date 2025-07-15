#!/bin/bash
#FLUX: --job-name=rmodel_Ssci
#FLUX: -n=36
#FLUX: --queue=nocona
#FLUX: --urgency=16

. ~/conda/etc/profile.d/conda.sh
conda activate
PROCESSORS=36
BATCHES=50
cd /path/to/working/directory
python rmodel.py -g /path/to/genome/assembly.$NAME.fa.gz -p $PROCESSORS -b $BATCHES -w /lustre/scratch//npaulat/arachnids/Ssci/
