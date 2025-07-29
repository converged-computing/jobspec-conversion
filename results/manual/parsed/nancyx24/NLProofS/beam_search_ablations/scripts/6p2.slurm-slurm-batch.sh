#!/bin/bash
#SBATCH --job-name=6p2
#SBATCH --output=../outputs/6p2.out
#SBATCH --mail-user=abiramg@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a5000:1
#SBATCH --mem=16G
#SBATCH --time=08:00:00

module purge
conda init bash
source ~/.bashrc
cd /n/fs/nlp-abiramg/NLProofS
conda activate nlproofs
cd prover
python main.py test --config cli_task2_stepwise_t5-large.yaml --log_name "6p2" --model.num_beam_groups 6 --model.diversity_penalty 2 --ckpt_path ../../weights/task2_stepwise.ckpt --model.verifier_weight 0.5 --model.verifier_ckpt ../../weights/task2_verifier.ckpt --model.proof_search true 
