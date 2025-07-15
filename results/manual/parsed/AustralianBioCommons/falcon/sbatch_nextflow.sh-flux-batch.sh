#!/bin/bash
#FLUX: --job-name=muffled-car-9785
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --priority=16

unset SBATCH_EXPORT
module load nextflow
srun nextflow run main.nf -profile conda
