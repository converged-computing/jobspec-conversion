#!/bin/bash
#FLUX: --job-name=NF_RNASeq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow
NEXTFLOW=nextflow
module load parallel fastqc python_3 salmon/0.10.1 kallisto/0.42.4 hisat2/2.2.0 gmap_gsnap/2020-04-08 samtools subread/2.0.2
cd ${SLURM_SUBMIT_DIR}
${NEXTFLOW} run main.nf \
  --reads "00_Raw-Data/*{1,2}.fastq.gz" \
  --genome "00_Raw-Data/*_genomic.fna.gz" \
  --genome_gff "00_Raw-Data/*.gff.gz" \
  --genome_cdna "00_Raw-Data/*_rna.fna.gz" \
  --queueSize 25 \
  -profile slurm \
  -resume
  #--account isu_gif_vrsc       #<= add this to Atlas
