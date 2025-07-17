#!/bin/bash
#FLUX: --job-name=boopy-latke-8553
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load python/3.5.2
pip install tensorflow-gpu==1.4.1 --user
pip install keras --user
pip install tqdm --user
pip install requests --user
pip install h5py --user
pip install SimpleITK --upgrade --user
module load cuda/8.0.44
module load cudnn/8.0-v6.0
module load gcc/4.9.2
python3 main.py
