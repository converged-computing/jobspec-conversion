#!/bin/bash
#SBATCH --output=outfiles/df1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=17g
#SBATCH --time=6-00:00:00
#SBATCH --partition=gpu

source activate pytorch_p37
cd /home/ianpan/ufrc/deepfake/skp/
/home/ianpan/anaconda3/envs/pytorch_p37/bin/python run.py configs/experiments/experiment045.yaml train --gpu 0 --num-workers 4 
