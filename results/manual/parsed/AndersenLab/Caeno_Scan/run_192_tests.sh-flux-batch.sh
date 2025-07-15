#!/bin/bash
#FLUX: --job-name=run_test_sims
#FLUX: --queue=genomicsguestA
#FLUX: -t=28800
#FLUX: --urgency=16

module load singularity
nextflow run multi_species_simfiles.nf
