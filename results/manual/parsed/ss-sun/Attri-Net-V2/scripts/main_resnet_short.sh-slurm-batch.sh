#!/bin/bash
#SBATCH --output=/mnt/qb/work/baumgartner/sun22/logs/hostname_%j.out
#SBATCH --error=/mnt/qb/work/baumgartner/sun22/logs/hostname_%j.err
#SBATCH --mail-user=<susu.sun@uni-tuebingen.de>
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=1-04:00:00
#SBATCH --partition=gpu-2080ti

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
