#!/bin/bash
#FLUX: --job-name=NF_refactor
#FLUX: -t=86400
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
nextflow run main.nf \
  --primary_assembly "/project/ag100pest/Pgos/RawData/3-unzip/all_p_ctg.fasta" \
  --illumina_reads "/project/ag100pest/Illumina_polishing/JAMU*{R1,R2}.fastq.bz2" \
  --pacbio_reads "/project/ag100pest/Pgos/RawData/m54334U_190823_194159.subreads.bam" \
  --k "21" \
  -resume
