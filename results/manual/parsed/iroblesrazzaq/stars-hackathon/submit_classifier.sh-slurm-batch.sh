#!/bin/bash
#SBATCH --account=pi-dfreedman
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --qos=schmidt

echo "output of the visible GPU environment"
nvidia-smi
module load python/miniforge-24.1.2 # python 3.10
source /project/dfreedman/hackathon/hackathon-env/bin/activate
echo Tensorflow
python MergeNeuralNetwork.py
