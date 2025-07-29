#!/bin/bash
#SBATCH --mail-user=your_email@soton.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=00:04:00
#SBATCH --partition=ecsstudents

module load conda/py3-latest
conda activate my-pytorch-env
python cifar.py
