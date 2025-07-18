#!/bin/bash
#FLUX: --job-name=stepwise_no_search_task_2
#FLUX: -t=28800
#FLUX: --urgency=16

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task2_stepwise_t5-large.yaml --ckpt_path ../../weights/task2_stepwise.ckpt --model.proof_search false
