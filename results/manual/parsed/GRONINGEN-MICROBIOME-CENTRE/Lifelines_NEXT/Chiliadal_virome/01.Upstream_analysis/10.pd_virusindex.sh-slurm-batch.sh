#!/bin/bash
#FLUX: --job-name=VIR_DB
#FLUX: -c=8
#FLUX: -t=7140
#FLUX: --urgency=16

module purge
module load Bowtie2
module load SAMtools
module list
mkdir -p ../VIR_DB/virus_contigs/w_neg_der95_index
bowtie2-build \
	../VIR_DB/virus_contigs/NEXT_vOTU_representatives_w_neg_der95.fasta \
	../VIR_DB/virus_contigs/w_neg_der95_index/w_neg_der95 \
	--large-index \
	--threads ${SLURM_CPUS_PER_TASK}
samtools faidx \
	../VIR_DB/virus_contigs/NEXT_vOTU_representatives_w_neg_der95.fasta
awk 'BEGIN {FS="\t"}; {print $1 FS "0" FS $2}' \
	../VIR_DB/virus_contigs/NEXT_vOTU_representatives_w_neg_der95.fasta.fai \
	> ../VIR_DB/virus_contigs/w_neg_der95_index/w_neg_der95.bed
mkdir -p ../VIR_DB/mapping/VLP_to_w_neg_der95/alignment_log
mkdir -p ../VIR_DB/mapping/VLP_to_w_neg_der95/coverage
module purge
