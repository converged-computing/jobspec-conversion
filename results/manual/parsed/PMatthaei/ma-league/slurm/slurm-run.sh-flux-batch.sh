#!/bin/bash
#FLUX: --job-name=ma-league
#FLUX: -t=43200
#FLUX: --priority=16

hostname
which python3
nvidia-smi
env
python3 -m venv ./venv/ma-league
source ./venv/ma-league/bin/activate
pip install -U pip setuptools wheel
cp ./requirements.txt .
pip install -r requirements.txt
pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
pip install git+https://github.com/PMatthaei/ma-env.git
python3 -c "import torch; print(torch.cuda.device_count())"
echo "Execute command as Slurm job..."
chmod 755 run.py
./run.py
