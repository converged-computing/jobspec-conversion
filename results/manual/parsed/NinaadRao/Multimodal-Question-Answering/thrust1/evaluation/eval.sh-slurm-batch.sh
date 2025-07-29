#!/bin/bash
#SBATCH --job-name=clevr-idefics-mqa
#SBATCH --output=clevr-idefics-mqa.out
#SBATCH --error=clevr-idefics-mqa.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A6000:1
#SBATCH --time=10:00:00
#SBATCH --constraint=ntasks-per-node=1

source ~/.bashrc
conda activate idefics
cd /home/naveensu/
python eval-idefics.py
