#!/bin/bash
#SBATCH --job-name=3dres
#SBATCH --output=3dres_%J.out
#SBATCH --error=3dres_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:maxwell:1
#SBATCH --mem=80G
#SBATCH --partition=high
#SBATCH --chdir=/homedtic/gmarti/LOGS

export PATH='$HOME/project/anaconda3/bin:$PATH'

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
export PATH="$HOME/project/anaconda3/bin:$PATH"
source activate dlnn
module load CUDA/9.0.176
module load cuDNN/7.0.5-CUDA-9.0.176
python /homedtic/gmarti/CODE/3d-conv-ad/train_res3dnet.py --config_file /homedtic/gmarti/CODE/3d-conv-ad/configs/config.ini --output_directory_name resnet_train
