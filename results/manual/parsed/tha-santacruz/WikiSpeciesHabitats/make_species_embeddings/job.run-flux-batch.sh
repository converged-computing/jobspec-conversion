#!/bin/bash
#FLUX: --job-name=phat-gato-5656
#FLUX: -c=8
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --priority=16

python make_species_doc2vec_species_embeddings.py
