#!/bin/bash
#SBATCH --job-name=TD3_FORK
#SBATCH --output=TD3_FORK/myPythonJob.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00
#SBATCH --qos=short

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
