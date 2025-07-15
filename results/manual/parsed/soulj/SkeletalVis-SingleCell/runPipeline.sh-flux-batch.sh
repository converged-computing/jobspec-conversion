#!/bin/bash
#FLUX: --job-name=moolicious-cinnamonbun-4524
#FLUX: --priority=16

module load singularity
module load adoptopenjdk
module load nextflow
accession=$1
echo "running cellranger pipeline for $accession"
nextflow run -profile slurm -w tmp/${accession}_tmp main.nf -params-file params/${accession}.yaml -with-singularity singlecell_latest.sif -entry CellRanger
