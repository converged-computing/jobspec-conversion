#!/bin/bash
#FLUX --job-name=gassy-leg-4098
#FLUX -c=2
#FLUX -t=129600
#FLUX --urgency=16

module load singularity
singularity exec -B ../SMARTS-lite:/SMARTS-lite --env DISPLAY=$DISPLAY,PYTHONPATH=/SMARTS-lite/ultra:/SMARTS-lite:$PYTHONPATH --home /SMARTS-lite/ultra ../smarts-0416_singularity.sif python ultra/hammer_train.py --task 0-3agents --level easy --policy ppo,ppo,ppo --headless
