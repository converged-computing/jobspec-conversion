#!/bin/bash
#SBATCH --job-name=nxf-se
#SBATCH --account=pawsey0159
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00

unset SBATCH_EXPORT
module load singularity
module load nextflow
nextflow run eDNAFlow.nf -profile zeus  --reads 'cook_georg_goc1_goc2_mind_plc_sach.fastq' --barcode '*.txt' --minsize '4' --minLen '50' --perc_identity '90' --maxTarSeq '10' --blast_db '/group/data/blast_v5/nt' 
