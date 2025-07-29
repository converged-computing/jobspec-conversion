#!/bin/bash
#SBATCH --job-name=DRL_FLEXLAB
#SBATCH --account=pc_mlee
#SBATCH --mail-user=mkiran@lbl.gov
#SBATCH --mail-type=begin,end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=00:20:30
#SBATCH --partition=cf1
#SBATCH --qos=cf_normal
#SBATCH --constraint=es1_v100

module load singularity/3.2.1
echo "module loaded"
singularity exec --bind /global/scratch/stouzani/DRL/DRL_FLEXLAB:/mnt/shared  /global/scratch/stouzani/DRL/drl_flexlab_1.sif cd /mnt/shared && pwd
/global/home/users/stouzani/DRL/DRL_FLEXLAB
singularity run --bind /global/home/users/stouzani/DRL/DRL_FLEXLAB:/mnt/shared  /global/home/users/stouzani/DRL/drl_flexlab_1.sif cd /mnt/shared && pwd
singularity run --bind `pwd`:/mnt/shared  /global/scratch/stouzani/Simages/drl_flexlab.simg cd /mnt/shared && pwd
module load singularity/3.2.1
echo "module loaded"
singularity exec --bind /global/home/users/stouzani/DRL/DRL_FLEXLAB:/mnt/shared new_drl_flexlab.simg python simulation/rl_train_ddpg.py
