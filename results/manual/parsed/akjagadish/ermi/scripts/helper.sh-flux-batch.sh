#!/bin/bash
#FLUX: --job-name=llama
#FLUX: -c=72
#FLUX: -t=900
#FLUX: --priority=16

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
