#!/bin/bash
#SBATCH --job-name=ip
#SBATCH --account=labate
#SBATCH --output=ip.o%j
#SBATCH --mail-user=hzhao25@cougarnet.uh.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00

hostname
module add cudatoolkit/11.6
module add torchvision/0.15.2-foss-2022a-CUDA-11.7.0
module add PyTorch/2.0.1-foss-2022a-CUDA-11.7.0
module add OpenCV/4.5.3-fosscuda-2021a-Python-3.8.2
module add opencv-python
module add matplotlib
module add scikit-learn
module add tqdm
python places2_train.py
