#!/bin/bash
#FLUX: --job-name=falcon_int_FT
#FLUX: -t=144000
#FLUX: --priority=16

export PATH_TO_STORAGE='/scratch/p313544/storage_cache/interpret_models/'

module purge
module load Python/3.9.6-GCCcore-11.2.0
module load CUDA/11.7.0
cd /home1/p313544
source .venv/bin/activate
echo "Python version: $(python --version)"
nvidia-smi
pwd
PATH_TO_PRJ=/home1/p313544/Documents/RewardLM
SCRIPT_NAME=interpretability/gen_attributes.py
export PATH_TO_STORAGE=/scratch/p313544/storage_cache/interpret_models/
cd $PATH_TO_PRJ
echo "[FT]"
python $SCRIPT_NAME -m configs/falcon7b-FT.yaml -i interpretability/interp_configs/i_debug_prod.yaml
echo "Done!"
