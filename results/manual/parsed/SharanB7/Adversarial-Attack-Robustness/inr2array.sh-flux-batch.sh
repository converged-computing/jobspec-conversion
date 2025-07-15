#!/bin/bash
#FLUX: --job-name=spicy-butter-5396
#FLUX: --urgency=16

module load mamba/latest
source activate inr2array
python -m experiments.make_latent_dset --rundir ./outputs/2024-01-05/13-57-00 --output_path experiments/data/mnist-embeddings.pt
python -m experiments.launch_classify_latent embedding_path=experiments/data/mnist-embeddings.pt
