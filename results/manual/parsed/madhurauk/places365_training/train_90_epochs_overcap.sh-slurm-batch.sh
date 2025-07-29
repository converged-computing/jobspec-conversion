#!/bin/bash
#SBATCH --job-name=resnet18
#SBATCH --account=overcap
#SBATCH --output=models/resnet18/logs-%j.out
#SBATCH --error=models/resnet18/logs-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --constraint=ntasks-per-node=8

source /nethome/mummettuguli3/anaconda2/bin/activate
conda activate my_basic_env_3
python train_placesCNN.py -a resnet18 --workers 40 /coc/scratch/mummettuguli3/data/places365_3/places365_standard
