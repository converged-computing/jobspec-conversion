#!/bin/bash
#FLUX: --job-name=gan
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

module load python
python /home/ImageGen/trainGAN_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/generateGAN_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_gan_seed.py $SLURM_ARRAY_TASK_ID
python /home/ImageGen/evaluation/evaluate_training_unscaled_gan_seed.py $SLURM_ARRAY_TASK_ID
