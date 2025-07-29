#!/bin/bash
#SBATCH --job-name=DeepLab_VOC
#SBATCH --mail-user=dghose@cs.umass.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=20

python main.py train --config-path configs/voc12.yaml --cuda
