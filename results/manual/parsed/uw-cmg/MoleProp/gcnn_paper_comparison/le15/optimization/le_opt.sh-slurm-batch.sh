#!/bin/bash
#SBATCH --output=/srv/home/xsun256//paper_comparison/le15/optimization/opt-4rd-b32_lr0005_dr0-4_e7-40_d256-512%j.out
#SBATCH --error=/srv/home/xsun256//paper_comparison/le15/optimization/opt-4rd-b32_lr0005_dr0-4_e7-40_d256-512%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=22G
#SBATCH --time=14-00:01:30
#SBATCH --partition=sbel_cmg
#SBATCH --qos=skunkworks_owner

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python /srv/home/xsun256/paper_comparison/le15/optimization/opt.py
