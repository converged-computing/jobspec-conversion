#!/bin/bash
#SBATCH --job-name=nest
#SBATCH --output=nest.out
#SBATCH --error=nest.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --gres=gpu:0
#SBATCH --time=4-04:39:00
#SBATCH --array=0-31

module load Anaconda3
source activate cnn
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch-lts -y
python -u train_alexnet_flexabile.py
