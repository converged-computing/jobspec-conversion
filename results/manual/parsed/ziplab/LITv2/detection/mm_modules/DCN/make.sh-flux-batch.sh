#!/bin/bash
#FLUX: --job-name=lovely-cinnamonbun-5522
#FLUX: --queue=m3g
#FLUX: -t=3600
#FLUX: --priority=16

export PROJECT='dl65'
export CONDA_ENVS_PATH='/projects/$PROJECT/$USER/conda_envs'
export CONDA_PKGS_DIRS='/projects/$PROJECT/$USER/conda_pkgs'

module load anaconda/2019.03-Python3.7-gcc5
module load gcc/5.4.0
module load cuda/10.1
module load cudnn/7.6.5-cuda10.1
export PROJECT=dl65
export CONDA_ENVS_PATH=/projects/$PROJECT/$USER/conda_envs
export CONDA_PKGS_DIRS=/projects/$PROJECT/$USER/conda_pkgs
source activate /projects/$PROJECT/$USER/conda_envs/defconv
which python
nvidia-smi
nvcc -V
python setup.py build install
