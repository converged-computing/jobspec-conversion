#!/bin/bash
#FLUX: --job-name=conll2003_train
#FLUX: --queue=gpu_prod_long
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='/opt/conda/bin:$PATH'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate new_PGx_env
conda install python=3.8
pip install --upgrade pip
python --version
rustc --version 
pip install setuptools_rust # Required for tokenizers which are required for transformers
pip install -r ./BARTNER/requirements.txt
pip install git+https://github.com/fastnlp/fastNLP@dev
pip install git+https://github.com/fastnlp/fitlog
python ./BARTNER/train.py --dataset_name conll2003
