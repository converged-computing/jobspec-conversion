#!/bin/bash
#FLUX: --job-name=swampy-peas-5283
#FLUX: -c=10
#FLUX: --priority=16

export LD_LIBRARY_PATH='/opt/conda/lib/'

module purge
module load anaconda
module load cuda/11.4.2
source activate falcon_40B
conda install -n falcon_40B python-dotenv
pip install -U -r requirements.txt
pip install -U --index-url https://aiinfra.pkgs.visualstudio.com/PublicPackages/_packaging/Triton-Nightly/pypi/simple/ triton-nightly
conda install -y cudatoolkit
export LD_LIBRARY_PATH='/opt/conda/lib/'
python ppo.py
