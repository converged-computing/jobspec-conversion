#!/bin/bash
#FLUX: --job-name=phat-butter-1046
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/18.10.1-bin
nextflow run -resume -profile pawsey_zeus ./phmm.nf --max_cpus 28 --nopfam --nouniref --msas "msas/mmseqs/*.fasta"
