#!/bin/bash
#FLUX: --job-name=outstanding-hippo-8296
#FLUX: -c=8
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

python make_species_doc2vec_species_embeddings.py
