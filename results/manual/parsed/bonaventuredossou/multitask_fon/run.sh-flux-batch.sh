#!/bin/bash
#FLUX: --job-name=multitaskfon
#FLUX: --queue=long
#FLUX: -t=604800
#FLUX: --urgency=16

module load python/3.9 cuda/10.2/cudnn/7.6
source /home/mila/b/bonaventure.dossou/env/bin/activate
cd /home/mila/b/bonaventure.dossou/multitask_fon
pip install -r requirements.txt
cd code
python run_train.py
