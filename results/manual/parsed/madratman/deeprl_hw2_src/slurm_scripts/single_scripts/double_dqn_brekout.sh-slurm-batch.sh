#!/bin/bash
#SBATCH --output=double_dqn_breakout_%j.out
#SBATCH --error=double_dqn_breakout_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=5-00:00:00
#SBATCH --partition=gpu
#SBATCH --nodelist=roberto

srun echo "I am on"
srun echo $HOSTNAME
srun echo "I got gpu number"
srun echo $CUDA_VISIBLE_DEVICES
srun echo "let the training begin"
srun nvidia-docker run --rm -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets -v /home/$USER:/home/$USER madratman/deeprl_hw /bin/bash -c "cd /home/ratneshm/courses/deeprl_hw2_src; python dqn_atari.py --mode='double' --env='breakout'"
