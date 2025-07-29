#!/bin/bash
#SBATCH --job-name=Contrastive_VIT
#SBATCH --account=lsfb
#SBATCH --output=./output/Contrastive_250.out
#SBATCH --mail-user=jerome.fink@unamur.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=4096
#SBATCH --time=20:00:00
#SBATCH --partition=gpu

module purge
module load PyTorch
source ./venv/bin/activate
pip install -r requirements.txt
nvidia-smi
python VIT_contrastive.py \
 -l 250\
 -e contrastive-250\
 -d /gpfs/projects/acad/lsfb/datasets/lsfb_v2/isol \
