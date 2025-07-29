#!/bin/bash
#SBATCH --job-name=suepml2
#SBATCH --output=/home/ap6964/suepml/logs/job2.log
#SBATCH --mail-user=ap6964@princeton.edu
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=8G
#SBATCH --time=09:00:00

module load anaconda3/2021.11
conda activate solaris
python3 /home/ap6964/suepml/train-classifier.py ResNet18-LabFrame-Classifier -c /home/ap6964/suepml/configs/resnet18-labframe-classifier.yml
