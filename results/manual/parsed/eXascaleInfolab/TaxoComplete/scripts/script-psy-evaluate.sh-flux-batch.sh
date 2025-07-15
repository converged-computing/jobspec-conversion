#!/bin/bash
#FLUX: --job-name=TaxoComplete
#FLUX: --queue=nodes
#FLUX: -t=190800
#FLUX: --priority=16

echo $(pwd)
module load miniconda/3
module load cuda/11.1
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate taxocomplete
python ./src/evaluate.py --config ./config_files_evaluate/psy/config_clst20_s47.json
python ./src/evaluate.py --config ./config_files_evaluate/psy/config_clst20_s48.json
python ./src/evaluate.py --config ./config_files_evaluate/psy/config_clst20_s49.json
python ./src/train.py --config ./config_files/psy/config_clst20_s47.json
python ./src/train.py --config ./config_files/psy/config_clst20_s48.json
python ./src/train.py --config ./config_files/psy/config_clst20_s49.json
conda deactivate
