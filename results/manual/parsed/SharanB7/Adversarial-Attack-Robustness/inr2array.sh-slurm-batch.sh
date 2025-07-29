#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=100G
#SBATCH --time=2-00:00:00

module load mamba/latest
source activate inr2array
python -m experiments.make_latent_dset --rundir ./outputs/2024-01-05/13-57-00 --output_path experiments/data/mnist-embeddings.pt
python -m experiments.launch_classify_latent embedding_path=experiments/data/mnist-embeddings.pt
