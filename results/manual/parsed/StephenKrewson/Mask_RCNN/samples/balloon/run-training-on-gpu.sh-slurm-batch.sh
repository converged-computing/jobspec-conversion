#!/bin/bash
#SBATCH --mail-user=stephen.krewson@yale.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:2
#SBATCH --mem=8g
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

module purge
module restore cuda
source deactivate
source activate maskRCNN
python balloon.py train --dataset=../../datasets/balloon --weights=last
