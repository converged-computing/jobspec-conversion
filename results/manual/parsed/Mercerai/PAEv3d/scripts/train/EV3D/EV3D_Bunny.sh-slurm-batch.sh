#!/bin/bash
#SBATCH --output=<absolute-path-to-code>/slurmlogs/%A-%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=06:00:00
#SBATCH --partition=gpu20
#SBATCH --array=1-5%1

CUDA_VISIBLE_DEVICES=1 python ddp_train_nerf.py --config configs/EV3D/Bunny.txt
CUDA_VISIBLE_DEVICES=1 python ddp_test_nerf.py --config configs/EV3D/Bunny.txt --render_split train --testskip 1
echo Finished
