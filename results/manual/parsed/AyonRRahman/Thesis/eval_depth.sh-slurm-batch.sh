#!/bin/bash
#SBATCH --job-name=eval_depth
#SBATCH --output=eval_depth.out
#SBATCH --error=eval_depth.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=04:00:00

which python
echo $HOSTNAME
nvidia-smi 
echo $HOSTNAME
python eval_depth.py --scale --depth_model udepth --saved_model saved_models/udepth_pretrained2/dispnet_model_best.pth.tar
