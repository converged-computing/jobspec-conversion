#!/bin/bash
#SBATCH --job-name=code-gan
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=10G
#SBATCH --time=3-00:00:00
#SBATCH --partition=clara-job
#SBATCH --constraint=ntasks-per-node=1

module load Python
cd /work/users/mi144quky
dir=$RANDOM
mkdir $dir
cd $dir
git clone https://REDACTED@github.com/mrchtr/code-gan.git
cd code-gan
git checkout clean-up
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1tjz92ShC3gwklJwNMr7nGJEXF6TvCS5X' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1tjz92ShC3gwklJwNMr7nGJEXF6TvCS5X" -O out_eval.txt && rm -rf /tmp/cookies.txt
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=13x-PzszXLCuf3-9132RjLVa5HGKA4eWB' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=13x-PzszXLCuf3-9132RjLVa5HGKA4eWB" -O out_train.txt && rm -rf /tmp/cookies.txt
mv out_eval.txt ./data/dataset/out_eval.txt
mv out_train.txt ./data/dataset/out_train.txt
pip install --user -r requirements.txt
module load CUDA
pip install wandb
wandb login 61c2320b5e0b3ff1e63f99f0f87409a917645546
python -u run.py
