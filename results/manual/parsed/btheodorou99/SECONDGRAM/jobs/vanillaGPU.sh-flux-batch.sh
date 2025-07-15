#!/bin/bash
#FLUX: --job-name=vanilla
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --priority=16

module load python
python /home/ImageGen/trainVanilla_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/generateVanilla_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_vanilla_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_unscaled_vanilla_seed.py $SLURM_ARRAY_TASK_ID
