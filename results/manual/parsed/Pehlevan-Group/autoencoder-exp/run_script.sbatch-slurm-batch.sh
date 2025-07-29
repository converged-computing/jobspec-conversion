#!/bin/bash
#SBATCH --output=myoutput_%j.out
#SBATCH --error=myerrors_%j.err
#SBATCH --mail-user=yibo_jiang@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=60000
#SBATCH --time=7-00:00:00

source activate pytorch
python3 auto_encoder_gd.py --input_dim $inputDim --nb_fixed_point $nbFixedPoint --nb_layer $nbLayer --hidden_dim $hiddenDim --dir $Dir --act $Act
