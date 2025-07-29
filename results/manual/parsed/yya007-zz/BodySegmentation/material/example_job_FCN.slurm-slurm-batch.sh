#!/bin/bash
#SBATCH --account=p_masi_gpu
#SBATCH --output=/scratch/huoy1/projects/DeepLearning/FCN/log/gpu-job.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=01:00:00

setpkgs -a tensorflow_0.12
source activate FCN
cd /scratch/yaoy4/BodySegmentation
python test_tf.py
