#!/bin/bash
#FLUX: --job-name=pusheena-nunchucks-8027
#FLUX: -c=8
#FLUX: --queue=fasse_gpu
#FLUX: -t=3540
#FLUX: --urgency=16

source ~/.bashrc
conda activate cuda116
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method pca &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method tsne &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method crae &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method cvae &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method unet &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method resnet &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method local &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method avg &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method wx &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method resnet_sup &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method unet_sup &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method unet_sup_car &
python train_sim_embs.py --silent --sim $SLURM_ARRAY_TASK_ID --task basic --method car &
wait
