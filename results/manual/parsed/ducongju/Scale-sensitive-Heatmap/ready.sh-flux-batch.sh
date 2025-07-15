#!/bin/bash
#FLUX: --job-name=stanky-signal-2883
#FLUX: --priority=16

eval "$(/opt/app/conda/bin/conda shell.bash hook)"
module load app/cuda/10.1
conda create -n sacle-sensitive python=3.6
conda activate scale-sensitive
pip install -r requirements.txt
git clone https://github.com/cocodataset/cocoapi.git
cd "cocoapi/PythonAPI"
python3 setup.py install --user
git clone https://github.com/Jeff-sjtu/CrowdPose.git
cd "../../crowdpose-api/PythonAPI"
sh install.sh
cd "../.."
python setup.py develop
