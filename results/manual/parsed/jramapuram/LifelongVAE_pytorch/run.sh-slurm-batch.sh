#!/bin/bash
#SBATCH --job-name=fashionmnist
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:pascal:1
#SBATCH --mem=6000
#SBATCH --time=12:00:00
#SBATCH --constraint=COMPUTE_CAPABILITY_6_0|COMPUTE_CAPABILITY_6_1

echo $CUDA_VISIBLE_DEVICES
srun python main.py --batch-size=300 --reparam-type="mixture" --discrete-size=100 --continuous-size=40 --epochs=200 --layer-type="conv" --ngpu=1 --optimizer=adam --mut-reg=0.0 --disable-regularizers --task fashion --uid=fashionvanilla --calculate-fid --visdom-url="http://login1.cluster" --visdom-port=8098
