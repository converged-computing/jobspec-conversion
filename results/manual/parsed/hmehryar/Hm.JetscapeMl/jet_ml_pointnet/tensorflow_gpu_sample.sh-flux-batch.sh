#!/bin/bash
#FLUX: --job-name=tensorflow_gpu_sample
#FLUX: --priority=16

echo "Converting notebook to script"
jupyter nbconvert --to python tensorflow_gpu_sample.ipynb
echo "Setting up python version and conda shell"
ml python/3.7
source /wsu/el7/pre-compiled/python/3.7/etc/profile.d/conda.sh
echo "Activating conda environment"
conda activate tensorflow-gpu-v2.8
echo "Running simulation"
python -u tensorflow_gpu_sample.py
