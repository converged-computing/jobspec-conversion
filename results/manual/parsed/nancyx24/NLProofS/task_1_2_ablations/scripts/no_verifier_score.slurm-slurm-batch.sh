#!/bin/bash
#FLUX: --job-name=no_verifier_score
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task1_stepwise_t5-large.yaml --ckpt_path ../../weights/task1_stepwise.ckpt --model.verifier_weight 0.0 --model.verifier_ckpt ../../weights/task1_verifier.ckpt --model.proof_search true
