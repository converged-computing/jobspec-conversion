#!/bin/bash
#FLUX: --job-name=NF-sox8
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
nextflow pull nf-core/rnaseq
nextflow run nf-core/rnaseq \
  -r 2.0 \
  -c ./configs/crick.config \
  --aligner star \
  --input ./NF-sox8_alignment/crick_samplesheet.csv \
  --outdir output/NF-sox8_alignment \
  --email alex.thiery@crick.ac.uk \
  -resume
