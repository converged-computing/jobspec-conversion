#!/bin/bash
#FLUX: --job-name=NF-atac
#FLUX: --priority=16

export TERM='xterm'
export NXF_VER='20.07.1'
export NXF_SINGULARITY_CACHEDIR='/camp/home/thierya/working/NF_singularity'

ml purge
ml Nextflow/20.07.1
ml Singularity/3.4.2
ml Graphviz
export TERM=xterm
export NXF_VER=20.07.1
export NXF_SINGULARITY_CACHEDIR=/camp/home/thierya/working/NF_singularity
nextflow pull nf-core/atacseq
nextflow run nf-core/atacseq \
    -r 1.2.0 \
    -c ./configs/crick.config \
    --input ./NF-ATAC_alignment/crick_samplesheet.csv \
    --macs_gsize 1.05e9 \
    --narrow_peak \
    --skip_diff_analysis \
    --outdir output/NF-ATAC_alignment \
    --email alex.thiery@crick.ac.uk \
    -resume
