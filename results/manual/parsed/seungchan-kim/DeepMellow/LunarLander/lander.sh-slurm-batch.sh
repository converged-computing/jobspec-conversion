#!/bin/bash
#SBATCH --job-name=TNUF1_DeepMellow
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

module load tensorflow/1.5.0_gpu_py3
module load cuda/9.0.176
module load cudnn/7.0
module load opengl/mesa-12.0.6
module load ffmpeg/4.0.1
for i in {1..50}
do
    /users/sk99/myenv/bin/python3 -u dqn-LunarLander-v2-mellow.py $i 1
    /users/sk99/myenv/bin/python3 -u dqn-LunarLander-v2-mellow.py $i 2
    /users/sk99/myenv/bin/python3 -u dqn-LunarLander-v2-mellow.py $i 5
done
