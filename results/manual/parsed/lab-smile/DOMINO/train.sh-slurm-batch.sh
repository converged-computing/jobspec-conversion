#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=4
#FLUX: --queue=hpg-ai
#FLUX: -t=259200
#FLUX: --urgency=16

module load singularity
singularity exec --nv <Enter path to MONAI container>/monaicore081 python3 -c "import torch; print(torch.cuda.is_available())"
singularity exec --nv --bind <Enter path to train file>:/mnt <Enter path to MONAI container>/monaicore081 python3 /mnt/train_domino.py --num_gpu 1 --data_dir '/mnt/<data folder name>/' --model_save_name "unetr_v5_domino_06-20-22" --N_classes 12 --max_iteration 100
