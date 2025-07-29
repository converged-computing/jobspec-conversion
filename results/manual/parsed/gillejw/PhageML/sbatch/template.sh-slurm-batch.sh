#!/bin/bash
#SBATCH --output=/scratch/gillejw/job-%j.out
#SBATCH --error=/scratch/gillejw/job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=5G
#SBATCH --time=01:00:00

module load python/3.9.2
module load cuda11.0/toolkit/11.0.3
source /home/gillejw/coding/PhageML/.env/bin/activate
pip install --quiet torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
pip3 install --user -r /home/gillejw/coding/PhageML/requirements.txt
python /home/gillejw/coding/PhageML/src/phageml.py /scratch/gillejw/data2/sequence_summary_10k.csv
