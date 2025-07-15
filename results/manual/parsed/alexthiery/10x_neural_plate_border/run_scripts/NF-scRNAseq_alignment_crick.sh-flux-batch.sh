#!/bin/bash
#FLUX: --job-name=10x-NPB
#FLUX: --priority=16

export TERM='xterm'
export NXF_VER='20.07.1'

export TERM=xterm
ml purge
ml Nextflow/20.07.1
ml Singularity/3.4.2
ml Graphviz
export NXF_VER=20.07.1
nextflow run ./NF-scRNAseq_alignment/main.nf \
--input ./NF-scRNAseq_alignment/crick_samplesheet.csv \
--outdir ./output/NF-scRNAseq_alignment \
-profile crick \
-resume
