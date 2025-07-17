#!/bin/bash
#FLUX: --job-name=lovable-parrot-0805
#FLUX: -c=8
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

python make_species_doc2vec_species_embeddings.py
