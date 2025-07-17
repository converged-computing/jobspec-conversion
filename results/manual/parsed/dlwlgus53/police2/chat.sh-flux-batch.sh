#!/bin/bash
#FLUX: --job-name=POL
#FLUX: --queue=3090
#FLUX: -t=259200
#FLUX: --urgency=16

export PYTHONPATH='.'

cd  $SLURM_SUBMIT_DIR
echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"
module purge
module add cuda/11.0
module add cuDNN/cuda/11.0/8.0.4.30
echo "Start"
echo "conda PATH "
echo "source  $HOME/anaconda3/etc/profile.d/conda.sh"
source  $HOME/anaconda3/etc/profile.d/conda.sh
echo "conda activate QA_new "
conda activate QA_new
export PYTHONPATH=.
conda activate QA_new
python main.py 
