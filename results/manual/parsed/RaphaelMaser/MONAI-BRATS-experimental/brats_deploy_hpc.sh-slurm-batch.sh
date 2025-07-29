#!/bin/bash
#SBATCH --job-name=BRATS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --time=04:00:00
#SBATCH --qos=normal

export PATH='$HOME/miniconda/bin:$PATH'

sleep 2s
nvidia-smi
export PATH="$HOME/miniconda/bin:$PATH"
source activate MONAI-BRATS
python brats_deploy.py --input "data/Task01_BrainTumour/imagesTr" --output "output/labels" --model "output/models"
