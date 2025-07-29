#!/bin/bash
#SBATCH --job-name=mistakes_were_made
#SBATCH --account=share-ie-imf
#SBATCH --output=job.out
#SBATCH --mail-user=eriko1306@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P100:1
#SBATCH --mem=16000
#SBATCH --time=01:00:00

module load PyTorch/1.7.1-fosscuda-2020b
source venv/bin/activate
python3 -m GPTime --task train --cfg_path configs/config_train.yml
