#!/bin/bash
#FLUX: --job-name=jk_spine_model
#FLUX: -c=2
#FLUX: --queue=titans
#FLUX: -t=604800
#FLUX: --urgency=16

echo "Node: $(hostname)"
echo "Start: $(date +%F-%R:%S)"
echo -e "Working dir: $(pwd)\n"
SCRATCH=/scratch/$USER
if [[ ! -d $SCRATCH ]]; then
  mkdir $SCRATCH
fi
source ~/JK_bachelor/.bashrc
module load CUDA/11.4
python VertebraeSegmentation/Verse/Predict_mask_titans.py --no-mps 
echo "Done: $(date +%F-%R:%S)"
