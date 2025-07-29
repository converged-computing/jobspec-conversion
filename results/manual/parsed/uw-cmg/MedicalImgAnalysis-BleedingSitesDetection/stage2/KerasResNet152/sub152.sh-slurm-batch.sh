#!/bin/bash
#SBATCH --account=cmg
#SBATCH --output=cuda_Training-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:rtx2080ti:1
#SBATCH --time=4-00:01:00
#SBATCH --partition=slurm_sbel_cmg
#SBATCH --qos=cmg_owner

module load usermods
module load user/cuda
source activate resnet 
pip install tensorflow-gpu
pip install keras
conda install --name resnet matplotlib 
conda install --name resnet -c anaconda scikit-learn  
conda install --name resnet numpy 
conda install --name resnet scipy 
conda install --name resnet pillow
conda install --name resnet scikit-image
python Focus152.py 
