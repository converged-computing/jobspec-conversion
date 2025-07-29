#!/bin/bash
#SBATCH --job-name=astmultistream
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16384
#SBATCH --time=1-16:00:00

module load python
pip install transformers datasets evaluate librosa torchmetrics opensmile scikit-learn nlpaug
python /home/snag0027/speech-depression/cluster/train_1d_conv.py
