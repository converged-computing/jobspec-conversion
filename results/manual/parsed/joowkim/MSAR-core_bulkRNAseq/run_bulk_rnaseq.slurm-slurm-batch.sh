#!/bin/bash
#FLUX: --job-name=nf-bulk_rnaseq
#FLUX: --queue=defq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/22.04.3
module load singularity/3.8.0
nextflow run bulk_rnaseq.nf -c ./bulk_rnaseq_conf/run.config -resume -profile slurm
module unload nextflow/22.04.3
module unload singularity/3.8.0
