#!/bin/bash
#FLUX: --job-name=SN_feat
#FLUX: -c=4
#FLUX: -t=14340
#FLUX: --urgency=16

date
echo "Loading anaconda..."
module load anaconda3
module load cuda/10.1.243
module list
source activate SoccerNet
echo "...Anaconda env loaded"
echo "Extracting features..."
python tools/ExtractResNET_TF2.py \
--soccernet_dirpath /ibex/scratch/giancos/SoccerNet/ \
--game_ID $SLURM_ARRAY_TASK_ID \
--back_end=TF2 \
--features=ResNET \
--video LQ \
--transform crop \
--verbose \
"$@"
echo "Features extracted..."
date
