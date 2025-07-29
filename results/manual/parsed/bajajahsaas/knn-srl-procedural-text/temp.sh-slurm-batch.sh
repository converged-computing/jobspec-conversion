#!/bin/bash
#SBATCH --job-name=prepare_data
#SBATCH --output=logsprepdata/prep_data_%j.txt
#SBATCH --error=logsprepdata/prep_data_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10000
#SBATCH --partition=m40-long

python -u copy_model/prepare_context.py original10.annoy original_bert.pkl train_embeddings10.pkl train_embeddings10.pkl train10.pkl scibert 4
exit
