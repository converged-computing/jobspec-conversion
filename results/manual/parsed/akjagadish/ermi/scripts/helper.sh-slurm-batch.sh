#!/bin/bash
#SBATCH --job-name=llama
#SBATCH --output=./logs/%A.out
#SBATCH --error=./logs/%A.err
#SBATCH --mail-user=akshaykjagadish@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --gres=gpu:a100:4
#SBATCH --mem=240G
#SBATCH --time=00:15:00
#SBATCH --constraint=gpu

cd ~/ermi/
module purge
module load anaconda/3/2021.11
module load gcc/11 impi/2021.6
module load cuda/11.6
module load pytorch_distributed/gpu-cuda-11.6/1.13.0
pip3 install --user accelerate openai gym ipdb transformers tensorboard anthropic openml wordcloud mycolorpy Pillow
clear
jupyter-lab
cd ~/ermi/categorisation/
module purge
module load anaconda/3/2021.11
module load gcc/11 impi/2021.6
module load cuda/11.6
module load pytorch_distributed/gpu-cuda-11.6/1.13.0
pip3 install --user accelerate openai gym ipdb transformers tensorboard anthropic
clear
tensorboard --logdir=runs/trained_models/ --port=6006
