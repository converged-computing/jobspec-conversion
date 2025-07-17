#!/bin/bash
#FLUX: --job-name=purple-house-2521
#FLUX: --queue=gpu2
#FLUX: -t=3600
#FLUX: --urgency=16

module load python/3.9.2
module load cuda11.0/toolkit/11.0.3
source /home/gillejw/coding/PhageML/.env/bin/activate
pip install --quiet torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
pip3 install --user -r /home/gillejw/coding/PhageML/requirements.txt
python /home/gillejw/coding/PhageML/src/phageml.py /scratch/gillejw/data2/sequence_summary_10k.csv
