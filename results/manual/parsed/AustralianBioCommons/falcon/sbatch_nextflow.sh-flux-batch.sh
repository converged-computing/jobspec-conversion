#!/bin/bash
#FLUX: --job-name=lovable-platanos-8487
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

unset SBATCH_EXPORT
module load nextflow
srun nextflow run main.nf -profile conda
