#!/bin/bash
#FLUX: --job-name=secondgram
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module load python
python /home/ImageGen/trainSECONDGRAM_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/generateSECONDGRAM_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_secondgram_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_unscaled_secondgram_seed.py $SLURM_ARRAY_TASK_ID
