#!/bin/bash
#SBATCH --output=/srv/home/nkrakauer/moleprop/paper_comparison/pan07/optimization/opt-pan07-%j.out
#SBATCH --error=/srv/home/nkrakauer/moleprop/paper_comparison/pan07/optimization/opt-pan07-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:01:30
#SBATCH --partition=sbel_cmg
#SBATCH --qos=skunkworks_owner

module load cuda/10.0
module load groupmods/cudnn/10.0
source activate deepchem
python -u /srv/home/nkrakauer/moleprop/paper_comparison/pan07/optimization/opt.py > buffer.txt
