#!/bin/bash
#FLUX: --job-name=NAME
#FLUX: -n=12
#FLUX: --queue=short
#FLUX: -t=57900
#FLUX: --urgency=16

export PATH='biome_tools/SPAdes-3.13.1-Linux/bin:$PATH'

ml gcc/7.1.0
ml fastqc/0.11.8
ml bowtie/2.2.9
ml STAR/2.5.2b
ml ncbi-blast/2.7.1
ml seqkit/0.9.0
export PATH=biome_tools/SPAdes-3.13.1-Linux/bin:$PATH
DATABASE=/scratch/Users/mame5141/2019/RNAseq-Biome-Nextflow
MAIN=/scratch/Users/mame5141/2019/RNAseq-Biome-Nextflow
PROJECT=${MAIN}"/NF_OUT"
BIN=${MAIN}/bin
mkdir -p $PROJECT
nextflow run ${MAIN}/main.nf -resume \
        -profile slurm \
        -with-report -with-trace -with-timeline -with-dag flowchart.png \
        --email "youremail@gmail.com" \
        --max_cpus 32 \
        --kmer_size 35 \
        --or rf \
        --fastqs ${MAIN}/"fastqs" \
        --sample_table "sample_table.txt" \
        --singleEnd false \
        --STAR_index ${DATABASE}/"ensembl" \
        --bowtie2_index ${DATABASE}/"ensembl/bowtie2_index/genome" \
        --ntblastDB ${DATABASE}/"blastDBall/nt" \        
        --bin ${BIN} \
        --workdir ${PROJECT}/temp \
        --outdir ${PROJECT} \        
        --unmappedPath ${PROJECT}/"unmapped"
