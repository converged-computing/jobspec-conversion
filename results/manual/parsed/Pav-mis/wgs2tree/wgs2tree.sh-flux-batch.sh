#!/bin/bash
#FLUX: --job-name=wgs2tree
#FLUX: --queue=highmem
#FLUX: -t=7200
#FLUX: --priority=16

module load singularity/3.11.4-nompi
module load nextflow/23.10.0
unset SBATCH_EXPORT
nextflow run wgs2tree/main.nf --lineage 'actinopterygii_odb10' --out 'NF'
