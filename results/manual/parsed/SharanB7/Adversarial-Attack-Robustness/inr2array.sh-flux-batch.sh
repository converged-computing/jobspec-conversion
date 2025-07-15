#!/bin/bash
#FLUX: --job-name=butterscotch-earthworm-3412
#FLUX: --priority=16

module load mamba/latest
source activate inr2array
python -m experiments.make_latent_dset --rundir ./outputs/2024-01-05/13-57-00 --output_path experiments/data/mnist-embeddings.pt
python -m experiments.launch_classify_latent embedding_path=experiments/data/mnist-embeddings.pt
