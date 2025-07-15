#!/bin/bash
#FLUX: --job-name=evalate
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

module purge
module load PyTorch/1.6.0-fosscuda-2019b-Python-3.7.4
pip install --user numpy transformers torch datasets dataloader pandas wandb scikit-learn protobuf
cd $HOME/NLP-NLI-explanations/
python3 evaluate.py
