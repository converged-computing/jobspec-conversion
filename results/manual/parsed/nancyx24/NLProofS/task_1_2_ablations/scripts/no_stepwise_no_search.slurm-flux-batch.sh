#!/bin/bash
#FLUX: --job-name=no_stepwise
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task1_single_shot_t5-large.yaml --ckpt_path ../../weights/task1_single_shot.ckpt
