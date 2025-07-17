#!/bin/bash
#FLUX: --job-name=TD3_FORK
#FLUX: --queue=ug-gpu-small
#FLUX: -t=86400
#FLUX: --urgency=16

python3 -m venv RL_Kernel
source /home2/cgmj52/ReinforcementLearning/RL_Kernel/bin/activate
pip install numpy matplotlib gym pyvirtualdisplay
pip install torch torchvision
pip install torch torchvision torchaudio
pip install setuptools==65.5.0 "wheel<0.40.0"
apt update
apt-get install python3-opengl
apt install xvfb -y
pip install 'swig'
pip install 'pyglet==1.5.27'
pip install 'pyvirtualdisplay==3.0'
pip install 'gym[box2d]==0.20.0'
python3 /home2/cgmj52/ReinforcementLearning/TD3_FORK/train_RL.py
deactivate
