#!/bin/bash
#SBATCH --output=log/hostname_%j.out
#SBATCH --error=log/hostname_%j.err
#SBATCH --mail-user=xiangwew@cs.cmu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:6
#SBATCH --mem=100
#SBATCH --time=3-00:00:00
#SBATCH --nodelist=calculon

nvidia-docker run --rm --ipc=host -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets  -v /home/$USER:/home/$USER  xiangwei/pytorch:cu80-latest sh /home/wangxiangwei/Program/Tools/train.sh
