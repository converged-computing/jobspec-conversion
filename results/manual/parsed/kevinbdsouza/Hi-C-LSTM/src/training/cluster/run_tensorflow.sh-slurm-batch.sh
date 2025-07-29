#!/bin/bash
#SBATCH --account=def-maxwl
#SBATCH --output=output%N-%j_tf_.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10000M
#SBATCH --time=00:02:00

module load cuda cudnn hdf5 python/3.6.3
source /home/smaslova/pytorch/bin/activate
tensorboard --logdir=./tensorboard_logs/ --host 0.0.0.0 &
