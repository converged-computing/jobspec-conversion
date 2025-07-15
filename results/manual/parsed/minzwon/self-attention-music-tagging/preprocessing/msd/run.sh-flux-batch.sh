#!/bin/bash
#FLUX: --job-name=spicy-puppy-7293
#FLUX: --urgency=16

module load Python/3.6.4-foss-2017a 
source /homedtic/mwon/envs/intel/bin/activate
python -u preprocess.py run '/datasets/MTG/audio/incoming/millionsong-audio/mp3/' '/homedtic/mwon/dataset/msd/' ${SLURM_ARRAY_TASK_ID} 20
