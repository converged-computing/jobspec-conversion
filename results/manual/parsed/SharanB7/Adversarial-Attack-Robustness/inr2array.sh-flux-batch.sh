#!/bin/bash
#FLUX: --job-name=arid-lentil-0118
#FLUX: -c=10
#FLUX: --queue=public
#FLUX: -t=172800
#FLUX: --urgency=16

module load mamba/latest
source activate inr2array
python -m experiments.make_latent_dset --rundir ./outputs/2024-01-05/13-57-00 --output_path experiments/data/mnist-embeddings.pt
python -m experiments.launch_classify_latent embedding_path=experiments/data/mnist-embeddings.pt
