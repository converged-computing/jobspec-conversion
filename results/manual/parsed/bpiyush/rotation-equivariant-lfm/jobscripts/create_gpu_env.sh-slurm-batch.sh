#!/bin/bash
#SBATCH --job-name=R2D2
#SBATCH --output=slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=10:00:00

module purge
module load 2021
module load Anaconda3/2021.05
echo "Creating an environment named 'relfm-v1.0'..."
echo "----------------------------------------"
repository_path=$(git rev-parse --show-toplevel)
echo "repository_path: $repository_path"
cd $repository_path
conda create -y -n relfm-v1.0 python=3.9
source deactivate
source activate relfm-v1.0
conda install -y tqdm pillow numpy matplotlib scipy
pip install ipdb ipython jupyter jupyterlab gdown termcolor natsort opencv-python
pip install torch==1.8.1+cu101 \
    torchvision==0.9.1+cu101 \
    torchaudio==0.8.1 \
    -f https://download.pytorch.org/whl/torch_stable.html
pip install escnn wandb
echo "----------------------------------------"
