#!/bin/bash
#SBATCH --job-name=InstallEnvironment
#SBATCH --output=slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=1
#SBATCH --time=00:30:00

module purge
module load 2022
module load Anaconda3/2022.05
module load CUDA/11.8.0
conda create -n llava python=3.10 -y
conda activate llava
cd $HOME/LLaVA-Grounding-experiment
TORCH_CUDA_ARCH_LIST='8.0' FORCE_CUDA=1
pip install --upgrade pip
pip install -e .
pip install -q transformers==4.36.2
pip install -U opencv-python
python -m pip install 'git+https://github.com/MaureenZOU/detectron2-xyz.git'
pip install git+https://github.com/cocodataset/panopticapi.git
cd  $HOME/LLaVA-Grounding-experiment/Mask2Former/mask2former/modeling/pixel_decoder/ops
python setup.py build install
