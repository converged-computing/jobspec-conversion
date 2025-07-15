#!/bin/bash
#FLUX: --job-name=setup
#FLUX: --queue=depablo-gpu
#FLUX: -t=172800
#FLUX: --priority=16

envName=python3.9_pytorch2.0
ofile=logFiles/conda_env_spectre.log
TORCH=2.0
CUDA=111
conda create --name $envName -y
conda activate $envName
conda install -y python=3.9 pytorch=2.0 pyg pytorch-scatter pytorch-sparse torchvision cudatoolkit=11.1 matplotlib imageio numpy jupyterlab pillow seaborn numba pandas scikit-learn scikit-image scipy pybigwig pybind11 sympy isort -c pytorch -c conda-forge -c bioconda -c pyg &>> $ofile
python3 -m pip install pynvml importmagic hic-straw hicrep pip install opencv-python &>> $ofile
conda env export > logFiles/env_local2.yml
conda deactivate
