#!/bin/bash
#FLUX: --job-name=10x-NPB
#FLUX: --urgency=16

export TERM='xterm'
export NXF_VER='21.10.6'
export NXF_SINGULARITY_CACHEDIR='/camp/home/thierya/working/singularity'

export TERM=xterm
ml purge
ml Nextflow/21.10.6
ml Singularity/3.4.2
ml Graphviz
export NXF_VER=21.10.6
export NXF_SINGULARITY_CACHEDIR=/camp/home/thierya/working/singularity
nextflow run ./NF-downstream_analysis/main.nf \
--input ./NF-downstream_analysis/samplesheet.csv \
--outdir ./output/NF-downstream_analysis \
--debug \
-profile crick \
-resume
