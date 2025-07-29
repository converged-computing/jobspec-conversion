#!/bin/bash
#SBATCH --job-name=global_analysis
#SBATCH --output=global_analysis_%j.out
#SBATCH --mail-user=jonathan.donnelly@maine.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=30gb
#SBATCH --time=1-00:23:45

source /home/jdonnelly/protoPNet/bin/activate
MODELDIR='saved_models/resnet50/datasets/CUB_200_2011/train/001/'
MODELNAME='30push0.8564.pth'
srun python3 global_analysis.py -gpuid='0' -modeldir $MODELDIR -model $MODELNAME
