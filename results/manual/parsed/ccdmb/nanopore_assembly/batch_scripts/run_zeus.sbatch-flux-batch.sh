#!/bin/bash
#FLUX --job-name=frigid-buttface-8329
#FLUX --queue=workq
#FLUX -t=86400
#FLUX --urgency=16

module load nextflow
module load java
srun --export=all nextflow run -profile singularity,zeus -resume ./main.nf --nanoporeReads '$*'
