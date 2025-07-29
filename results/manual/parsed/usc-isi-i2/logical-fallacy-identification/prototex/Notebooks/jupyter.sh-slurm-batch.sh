#!/bin/bash
#SBATCH --job-name=jupyter
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10240
#SBATCH --time=3-00:00:00
#SBATCH --partition=nodes
#SBATCH --chdir=/cluster/raid/home/himanshu.rawlani/propaganda_detection/prototex_custom/Notebooks

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate prototex
echo "*** Starting jupyter on:"$(hostname)
jupyter notebook --no-browser --port=9876
conda deactivate
