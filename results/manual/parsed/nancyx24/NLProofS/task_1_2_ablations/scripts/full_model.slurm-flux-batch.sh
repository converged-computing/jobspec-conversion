#!/bin/bash
#FLUX: --job-name=hairy-squidward-1214
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task1_stepwise_t5-large.yaml --log_name full_model_{$1} --ckpt_path ../../weights/task1_stepwise.ckpt --model.verifier_weight 0.5 --model.verifier_ckpt ../../weights/task1_verifier.ckpt --model.proof_search true 
