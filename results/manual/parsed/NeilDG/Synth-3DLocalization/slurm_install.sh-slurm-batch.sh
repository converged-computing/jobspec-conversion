#!/bin/bash
#SBATCH --job-name=INSTALL
#SBATCH --output=script_install.out
#SBATCH --mail-user=neil.delgallego@dlsu.edu.ph
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --qos=84c-1d_serial

module load anaconda/3-2021.11
module load cuda/10.1_cudnn-7.6.5
source activate NeilGAN_V2
pip-review --local --auto
pip install -I torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install scikit-learn
pip install scikit-image
pip install visdom
pip install kornia
pip install -I opencv-python==4.5.5.62
pip install --upgrade pillow
pip install gputil
pip install matplotlib
pip install --upgrade --no-cache-dir gdown
pip install PyYAML
