#!/bin/bash
#FLUX: --job-name=run_wrkflw
#FLUX: -c=40
#FLUX: --queue=htc
#FLUX: --urgency=16

module load singularity
module load nextflow
nextflow run xas_main.nf -profile slurm_singularity
