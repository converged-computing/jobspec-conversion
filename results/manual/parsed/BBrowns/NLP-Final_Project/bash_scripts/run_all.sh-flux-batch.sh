#!/bin/bash
#FLUX: --job-name=run_all
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

export WANDB_API_KEY='fe3882bf82f8cd42cf904bc39bf7d2630e31f395'

module purge
module load PyTorch/1.6.0-fosscuda-2019b-Python-3.7.4
pip install --user numpy transformers torch datasets dataloader pandas wandb scikit-learn protobuf
export WANDB_API_KEY=fe3882bf82f8cd42cf904bc39bf7d2630e31f395
cd $HOME/NLP-NLI-explanations/
python3 t5_trainer.py
