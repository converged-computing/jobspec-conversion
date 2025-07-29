#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=32
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}'

module purge
module load GCC/11.2.0  OpenMPI/4.1.1
module load cuDNN/8.2.2.26-CUDA-11.4.1
ml Anaconda3/2021.05
source activate
conda init bash
conda activate quant
nvidia-smi
export LD_LIBRARY_PATH=${CONDA_PREFIX}/lib:${LD_LIBRARY_PATH}
pip --version # check if the correct python version is used
cd ../src; python mt_train.py
