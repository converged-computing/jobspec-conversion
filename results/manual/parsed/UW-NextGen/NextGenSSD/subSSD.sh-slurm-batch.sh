#!/bin/bash
#SBATCH --output=cuda_Training-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:gtx1080:1
#SBATCH --time=00:12:00
#SBATCH --partition=slurm_courtesy

module load usermods
module load user/cuda
source activate ssd
conda install --name ssd numpy --yes
conda install --name ssd tensorflow-gpu --yes
conda install -c anaconda --name ssd keras-gpu --yes
conda install -c anaconda --name ssd matplotlib --yes
conda install -c anaconda --name ssd beautifulsoup4 --yes 
conda install -c anaconda --name ssd scikit-learn --yes
conda install -c anaconda --name ssd Pillow --yes
conda install --name ssd opencv --yes
conda install --name ssd tqdm --yes
python3 train.py 
