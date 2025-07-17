#!/bin/bash
#FLUX: --job-name=3p8
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task2_stepwise_t5-large.yaml --log_name "3p8" --model.num_beam_groups 3 --model.diversity_penalty 8 --ckpt_path ../../weights/task2_stepwise.ckpt --model.verifier_weight 0.5 --model.verifier_ckpt ../../weights/task2_verifier.ckpt --model.proof_search true 
