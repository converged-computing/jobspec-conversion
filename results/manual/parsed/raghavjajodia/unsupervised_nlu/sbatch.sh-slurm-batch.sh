#!/bin/bash
#FLUX: --job-name=test
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load cuda/9.0.176
eval "$(conda shell.bash hook)"
conda activate dgl_env
srun python3 LM_LatentVariable.py --dataroot /misc/vlgscratch4/BrunaGroup/rj1408/nlu/ptb_wsj_pos/ \
    --batchSize 64 --outf /misc/vlgscratch4/BrunaGroup/rj1408/nlu/ptb_wsj_pos/models/test/a/ \
    --cuda
