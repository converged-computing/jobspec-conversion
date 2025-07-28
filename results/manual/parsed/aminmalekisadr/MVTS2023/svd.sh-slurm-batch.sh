#!/bin/bash
#FLUX: --job-name=MVVGE-svd
#FLUX: -n=2
#FLUX: -c=2
#FLUX: --queue=gpu_p100
#FLUX: -t=604800
#FLUX: --urgency=16

echo "Cuda device: $CUDA_VISIBLE_DEVICES"
echo "======= Start memory test ======="
module load anaconda/3.2020.02
MY_CONDA_ENV="gpu100a"
CHK_ENV=$(conda  env list | grep $MY_CONDA_ENV | awk '{print $1}')
echo "CHK_ENV: $CHK_ENV"
if [ "$CHK_ENV" =  "" ]; then
        ## if MY_CONDA_ENV does not exist
        echo "$MY_CONDA_ENV doesn't exist, create it..."
        conda create --yes  --name $MY_CONDA_ENV python=3.6 cudatoolkit tensorflow-gpu isort panda -c conda-forge -c anaconda -c nvidia 
        conda activate $MY_CONDA_ENV
        #echo "=== Install tensorflow"
        #conda install --yes cudatoolkit tensorflow-gpu -c anaconda -c nvidia
else
        ## if MY_CONDA_ENV already exist
        echo "MY_CONDA_ENV exists, activate $MY_CONDA_ENV"
        #conda init bash
        conda activate $MY_CONDA_ENV
fi
python main.py experiments/Config.yaml SMD svd
