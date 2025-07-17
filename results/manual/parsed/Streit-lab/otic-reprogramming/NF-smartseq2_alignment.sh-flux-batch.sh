#!/bin/bash
#FLUX: --job-name=NF-smartseq2
#FLUX: -t=259200
#FLUX: --urgency=16

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
nextflow run ./NF-smartseq2_alignment/main.nf \
  -c ./configs/crick.config \
  --input ./NF-smartseq2_alignment/crick_samplesheet.csv \
  --outdir output/NF-smartseq2_alignment \
  -resume
