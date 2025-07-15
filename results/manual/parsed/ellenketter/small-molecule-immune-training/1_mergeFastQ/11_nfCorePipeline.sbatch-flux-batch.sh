#!/bin/bash
#FLUX: --job-name=nfcore
#FLUX: -n=10
#FLUX: --queue=lbarreiro
#FLUX: -t=86400
#FLUX: --priority=16

export PATH='$PATH:/project/lbarreiro/USERS/ellen/programs/FastQC/'

export PATH=$PATH:/project/lbarreiro/USERS/ellen/programs/
export PATH=$PATH:/project/lbarreiro/USERS/ellen/programs/FastQC/
module load java
cd /project/lbarreiro/USERS/ellen/KnightMolecules/analysis/
nextflow run nf-core/atacseq --input samplesheet.csv --outdir 11_mergeFastQ/ --genome GRCm38 --read_length 50 -r 2.0
