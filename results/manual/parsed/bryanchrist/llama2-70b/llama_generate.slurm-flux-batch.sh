#!/bin/bash
#FLUX: --job-name=crusty-lentil-3281
#FLUX: -c=10
#FLUX: --priority=16

export LD_LIBRARY_PATH='/opt/conda/lib/' '

module purge
module load anaconda
module load cuda/11.4.2
source activate falcon_40B
conda install -n falcon_40B python-dotenv
pip install -U -r requirements.txt
conda install -y cudatoolkit
export LD_LIBRARY_PATH='/opt/conda/lib/' 
python generate.py
