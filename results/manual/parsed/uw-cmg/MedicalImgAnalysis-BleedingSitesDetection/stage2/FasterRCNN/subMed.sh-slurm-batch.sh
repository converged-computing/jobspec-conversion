#!/bin/bash
#SBATCH --account=cmg
#SBATCH --output=cuda_Training-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=14-00:03:00
#SBATCH --partition=slurm_priority
#SBATCH --qos=priority

module load usermods
module load user/cuda
source activate chainercv
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install scikit-image 
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install cupy-cuda90 
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install opencv-python
/srv/home/shenmr/anaconda3/envs/chainercv/bin/pip install Pillow
python train.py
