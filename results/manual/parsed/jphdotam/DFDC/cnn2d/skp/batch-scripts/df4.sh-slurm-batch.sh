#!/bin/bash
#SBATCH --output=outfiles/df4.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --time=6-00:00:00

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python run.py configs/experiments/experiment026.yaml train --gpu 0,1,2,3 --num-workers 4 
