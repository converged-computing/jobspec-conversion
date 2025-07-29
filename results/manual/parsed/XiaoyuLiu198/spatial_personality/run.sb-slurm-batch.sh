#!/bin/bash
#SBATCH --job-name=twi_infer_0
#SBATCH --account=soc121
#SBATCH --output=twi_infer_0.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=4
#SBATCH --mem=90G
#SBATCH --time=16:00:00
#SBATCH --constraint=ntasks-per-node=1

module load gpu/0.15.4
module load anaconda3/2020.11
git clone https://github.com/XiaoyuLiu198/spatial_personality.git
cd spatial_personality
mkdir results
mkdir twitter_prompts
mkdir ckpts
pip install -r requirements.txt
cd twitter_prompts
wget  --no-check-certificate 'https://docs.google.com/uc?export=download&id=1CUxYShXbIkC9qnxoT3lFFneDWZlCrqbn' -O post_sample_1199.csv
readlink -f post_sample_1199.csv
cd ..
cd ckpts
pip uninstall gdown
pip install gdown==4.6.0
gdown https://drive.google.com/uc?id=1JTkg-z211GusTeY-ZU-IIQcq7wy1ovDr
unzip conscientiousness_ckpts.zip
cd ..
python single.py --file /twitter_prompts/ --checkpoint /ckpts/content/drive/MyDrive/twitter_inference_data/ckpts/conscientiousness --destination /results/ --start 1199 --end 1200
