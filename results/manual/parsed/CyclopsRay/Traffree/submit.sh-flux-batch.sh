#!/bin/bash
#FLUX: --job-name=faux-kerfuffle-4121
#FLUX: -t=86400
#FLUX: --urgency=16

module load anaconda/2022.05
source /gpfs/runtime/opt/anaconda/2022.05/etc/profile.d/conda.sh
module load tree
cd finalProject
conda activate finalProject
pip install tqdm
pwd
python create_task.py
