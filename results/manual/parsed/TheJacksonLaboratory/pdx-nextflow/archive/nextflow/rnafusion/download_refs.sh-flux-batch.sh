#!/bin/bash
#FLUX: --job-name=SlurmJob
#FLUX: -t=259200
#FLUX: --urgency=16

nextflow run ./download-references.nf -profile singularity --download_all --cosmic_usr mike.lloyd@jax.org --cosmic_passwd YSYLTvNy72fvxg!
