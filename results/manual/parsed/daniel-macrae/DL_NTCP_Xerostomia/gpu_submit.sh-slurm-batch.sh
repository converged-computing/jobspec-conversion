#!/bin/bash
#FLUX: --job-name=Xerostomia_1
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

module purge
module load Python/3.11.3-GCCcore-12.3.0
python3 -m venv /scratch/$USER/.envs/HNC_env
source /scratch/$USER/.envs/HNC_env/bin/activate
pip install --upgrade pip
pip3 install torch torchvision torchaudio
pip3 install torchinfo tqdm monai pytz SimpleITK pydicom scikit-image matplotlib numpy 
pip3 install torch_optimizer
pip3 install scikit-learn opencv-python
pip3 install timm
pip3 install pandas
module purge
module load Python/3.11.3-GCCcore-12.3.0
source /scratch/$USER/.envs/HNC_env/bin/activate
python3 -u main.py
