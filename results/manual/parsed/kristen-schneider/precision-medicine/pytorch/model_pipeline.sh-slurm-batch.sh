#!/bin/bash
#FLUX: --job-name=gt_similarity_search
#FLUX: --queue=aa100
#FLUX: -t=86400
#FLUX: --urgency=16

snakemake -s training_pipeline.smk -j 32 -c 32 --use-conda --conda-frontend mamba
