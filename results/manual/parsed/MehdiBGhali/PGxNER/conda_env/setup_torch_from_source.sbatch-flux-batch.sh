#!/bin/bash
#FLUX: --job-name=torch_install_from_source
#FLUX: --queue=gpu_prod_long
#FLUX: -t=43200
#FLUX: --priority=16

export PATH='/opt/conda/bin:$PATH'
export CMAKE_PREFIX_PATH='${CONDA_PREFIX:-"$(dirname $(which conda))/../"}'

echo "Running on $(hostname)"
export PATH=/opt/conda/bin:$PATH
conda info --envs
source activate final_PGx_env_latest_transformers
conda list cudatoolkit
conda install -c "nvidia/label/cuda-11.7" cuda-nvcc
pip uninstall torch -y
conda uninstall torch -y
conda install cmake ninja
rm -r pytorch
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
pip install -r requirements.txt
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
python setup.py develop
