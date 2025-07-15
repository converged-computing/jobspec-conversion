#!/bin/bash
#FLUX: --job-name=KABROLG
#FLUX: -c=4
#FLUX: --queue=main
#FLUX: -t=720
#FLUX: --urgency=16

module load cuda/10.1
source ../lm/bin/activate
filename=train.sh
chmod +x $filename
. $filename
"""
module load python/3.7
virtualenv lm
source lm/bin/activate
pip install --upgrade pip
git clone https://github.com/Tikquuss/lm
cd lm
pip install -r requirements.txt
pip3 install packaging
pip install importlib-metadata
pip install transformers -U
pip3 install python-dateutil
pip uninstall attr
pip install attrs
tmux
chmod +x cluster.sh
salloc --gres=gpu:2 -c 4 --mem=32Gb --time=12:00:00 --partition=main --job-name=KABROLG
. cluster.sh
srun --gres=gpu:2 -c 4 --mem=32Gb --time=12:00:00 --partition=main --job-name=KABROLG . cluster.sh
sbatch . cluster.sh
"""
