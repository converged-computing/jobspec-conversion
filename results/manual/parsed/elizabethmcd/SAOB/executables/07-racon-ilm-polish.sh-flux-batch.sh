#!/bin/bash
#FLUX: --job-name=07-racon_ilm_polish
#FLUX: -c=16
#FLUX: -t=36000
#FLUX: --urgency=16

project_path="/project/6049207/AD_metagenome-Elizabeth"
read_path="${project_path}/illumina_qced/racon_ilm_input/R2Sept2020_qced.renamed.interleaved.fastq"
assembly_path="${project_path}/06_medaka_polish"
out_path="${project_path}/07_racon_ilm_polished"
module load racon bowtie2
mkdir ${out_path}
bowtie2 -x ${assembly_path}/consensus -U ${read_path} -q --no-unal --sensitive -p 16 -S ${out_path}/ilm_to_medaka_consensus_x1.sam
racon -t 16 -u \
${read_path} \
${out_path}/ilm_to_medaka_consensus_x1.sam \
${assembly_path}/consensus.fasta > ${out_path}/contigs_medaka.consensus_racon.ilm_x1.fasta
