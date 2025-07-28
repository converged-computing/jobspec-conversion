#!/bin/bash
#FLUX: --job-name=FHAI
#FLUX: --urgency=16

virtualenv -p python3 venv
source venv/bin/activate
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.8 get-pip.py
pip install copy logging typing random math matplotlib matplotlib.pyplot numplotnumpy==1.19.5 pandas==1.3.0 
pip install  torch scikit-learn==0.24.2 torchvision==0.9.1 tqdm==4.61.1 torch-utils-data==0.2.0 
pip install imbalanced-learn==0.8.0 seaborn==0.11.1 
pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
pip install --upgrade jupyter
pip install --upgrade ipywidgets
pip install  pillow
cd /local/scratch/cfikes/FHAI_3/Conditional_MNIST
python3.8 MNIST_AUG.py
