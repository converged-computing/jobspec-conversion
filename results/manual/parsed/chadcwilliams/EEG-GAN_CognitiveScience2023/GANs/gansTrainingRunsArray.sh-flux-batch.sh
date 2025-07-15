#!/bin/bash
#FLUX: --job-name=scruptious-kitty-9512
#FLUX: --urgency=16

module load python/3.9.0
module load gcc/10.2
module load cuda/11.7.1
module load cudnn/8.2.0
source ./venv/bin/activate
dataFile="`sed -n ${SLURM_ARRAY_TASK_ID}p gansTrainingFiles.txt`"
python gan_training_main.py ddp filter_generator path_dataset="${dataFile}" n_epochs=8000
