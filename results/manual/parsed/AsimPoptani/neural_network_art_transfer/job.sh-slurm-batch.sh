#!/bin/bash
#FLUX: --job-name=nn_art_transfer
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

echo "Pulling latest"
git pull
echo "Loading Modules"
module load lang/Python/3.8.2-GCCcore-9.3.0
module load system/CUDA/10.1.243-GCC-8.3.0
module load numlib/cuDNN/7.6.4.38-gcccuda-2019b
nvidia-smi --gpu-reset
if [ -d "venv" ]; then
   echo "Found previous venv deleting"
   rm -rf venv
fi
if [ -d "generated_images" ]; then
    echo "Found previous generated images deleting"
    rm -rf generated_images
fi
mkdir -p generated_images
echo "Setting up venv"
pwd
python3 -m venv venv
source venv/bin/activate
echo "upgarding pip"
python3 -m pip install --upgrade pip
echo "Installing requiremnts"
python3 -m pip install -r requirements.txt
python3 index.py
