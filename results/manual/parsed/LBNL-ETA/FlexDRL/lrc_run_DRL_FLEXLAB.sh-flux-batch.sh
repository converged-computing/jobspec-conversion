#!/bin/bash
#FLUX: --job-name=DRL_FLEXLAB
#FLUX: -c=6
#FLUX: --queue=cf1
#FLUX: -t=1230
#FLUX: --priority=16

module load singularity/3.2.1
echo "module loaded"
singularity exec --bind /global/scratch/stouzani/DRL/DRL_FLEXLAB:/mnt/shared  /global/scratch/stouzani/DRL/drl_flexlab_1.sif cd /mnt/shared && pwd
/global/home/users/stouzani/DRL/DRL_FLEXLAB
singularity run --bind /global/home/users/stouzani/DRL/DRL_FLEXLAB:/mnt/shared  /global/home/users/stouzani/DRL/drl_flexlab_1.sif cd /mnt/shared && pwd
singularity run --bind `pwd`:/mnt/shared  /global/scratch/stouzani/Simages/drl_flexlab.simg cd /mnt/shared && pwd
module load singularity/3.2.1
echo "module loaded"
singularity exec --bind /global/home/users/stouzani/DRL/DRL_FLEXLAB:/mnt/shared new_drl_flexlab.simg python simulation/rl_train_ddpg.py
