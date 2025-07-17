#!/bin/bash
#FLUX: --job-name=run_simfiles
#FLUX: --queue=genomicsguestA
#FLUX: -t=10800
#FLUX: --urgency=16

module load singularity
nextflow run prepare_sims.nf --ld true --out 20230824_sim_files_ld_0.01 
