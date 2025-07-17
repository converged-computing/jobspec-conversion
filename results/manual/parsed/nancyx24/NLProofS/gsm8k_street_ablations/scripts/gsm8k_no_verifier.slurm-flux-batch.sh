#!/bin/bash
#FLUX: --job-name=1_0
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config gsm8k.yaml
