#!/bin/bash
#FLUX: --job-name=bloated-squidward-0973
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --priority=16

module load nextflow
module load java
srun --export=all nextflow run -profile singularity,zeus -resume ./main.nf --nanoporeReads '$*'
