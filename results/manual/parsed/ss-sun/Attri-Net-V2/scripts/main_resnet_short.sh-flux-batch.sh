#!/bin/bash
#FLUX: --job-name=creamy-destiny-8322
#FLUX: --queue=gpu-2080ti
#FLUX: -t=100800
#FLUX: --urgency=16

scontrol show job $SLURM_JOB_ID 
echo "---------- JOB INFOS ------------"
scontrol show job $SLURM_JOB_ID 
echo -e "---------------------------------\n"
source /mnt/qb/home/baumgartner/sun22/.bashrc
cd /mnt/qb/work/baumgartner/sun22/github_projects/tmi
conda activate tt_interaction
echo "-------- PYTHON OUTPUT ----------"
python3 main_resnet.py --dataset "vindr_cxr" --epochs 75
echo "---------------------------------"
conda deactivate
