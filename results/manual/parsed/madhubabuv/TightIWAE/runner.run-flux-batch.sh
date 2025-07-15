#!/bin/bash
#FLUX: --job-name=TightIWAE
#FLUX: --queue=htc
#FLUX: -t=432000
#FLUX: --priority=16

module load anaconda3/2019.03
module load gpu/cuda/10.0.130
module load gpu/cudnn/7.5.0__cuda-10.0
source activate $DATA/bayesian-env
cd $DATA/python_codes/TightIWAE/
nvidia-smi
python miwae_simplified.py --piwae --k 8 --M 8 --dataset_name mnist
python miwae_simplified.py --miwae --k 8 --M 8 --dataset_name mnist
python miwae_simplified.py --miwae --k 64 --M 1 --dataset_name mnist
python miwae_simplified.py --ciwae --beta 0.5 --dataset_name mnist
python miwae_simplified.py --miwae --k 1 --M 1 --dataset_name mnist
echo "Finished!"
