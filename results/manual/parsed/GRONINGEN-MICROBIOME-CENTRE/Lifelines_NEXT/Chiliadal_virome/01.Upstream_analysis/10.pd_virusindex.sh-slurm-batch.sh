#!/bin/bash
#SBATCH --job-name=VIR_DB
#SBATCH --output=./out/10.vin/PD_w_neg_index.out
#SBATCH --error=./err/10.vin/PD_w_neg_index.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32gb
#SBATCH --time=01:59:00

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
