#!/bin/bash
#FLUX: --job-name=kallisto
#FLUX: -c=15
#FLUX: --queue=general
#FLUX: --urgency=16

hostname
date
module load kallisto/0.46.1
module load parallel/20180122
module load gffread/0.12.7
module load samtools/1.12
INDIR=../02_quality_control/trimmed_sequences
ENSEMBL=quant_ensembl
mkdir -p $ENSEMBL
ACCLIST=../01_raw_data/accessionlist.txt
CDS=../genome/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.cds.all.fa
kallisto index -i ensembl_transcripts.idx $CDS
cat $ACCLIST | \
parallel -j 5 \
    "kallisto quant \
        -i ensembl_transcripts.idx \
        -o $ENSEMBL/{} \
        -b 100 \
        <(zcat $INDIR/{}_trim_1.fastq.gz) \
        <(zcat $INDIR/{}_trim_2.fastq.gz)"
GTF=../genome/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.105.gtf
paste \
    <(awk '$3 ~ /transcript/' $GTF | grep -oP "(?<=gene_id \")[A-Z0-9]+") \
    <(awk '$3 ~ /transcript/' $GTF | grep -oP "(?<=transcript_id \")[A-Z0-9]+") \
>ensembl_gene2tx.txt
