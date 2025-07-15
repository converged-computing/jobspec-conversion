#!/bin/bash
#FLUX: --job-name=nxf-se
#FLUX: --queue=longq
#FLUX: -t=345600
#FLUX: --priority=16

unset SBATCH_EXPORT
module load singularity
module load nextflow
nextflow run eDNAFlow.nf -profile zeus  --reads 'cook_georg_goc1_goc2_mind_plc_sach.fastq' --barcode '*.txt' --minsize '4' --minLen '50' --perc_identity '90' --maxTarSeq '10' --blast_db '/group/data/blast_v5/nt' 
