#!/bin/bash
#SBATCH --job-name=iterative-bp-cnn
#SBATCH --output=output.txt
#SBATCH --error=error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:K80:1
#SBATCH --mem=16000
#SBATCH --time=4-00:00:00

module load nvidia/latest
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate iterative-bp-cnn
python3 ~/Iterative-BP-CNN/main.py -Func Train
conda deactivate
