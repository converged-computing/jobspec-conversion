#!/bin/bash
#FLUX: --job-name=10x-NPB
#FLUX: --priority=16

export TERM='xterm'
export NXF_VER='20.07.1'
export NXF_SINGULARITY_CACHEDIR='/nemo/lab/briscoej/working/hamrude/NF_singularity'
export NXF_HOME='/flask/scratch/briscoej/hamrude/10x_neural_plate_border_EH/NF-downstream_analysis'
export NXF_WORK='work/'

export TERM=xterm
export NXF_VER=20.07.1
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/briscoej/working/hamrude/NF_singularity
export NXF_HOME=/flask/scratch/briscoej/hamrude/10x_neural_plate_border_EH/NF-downstream_analysis
export NXF_WORK=work/
ml purge
ml Nextflow/20.07.1
ml Singularity/3.4.2
ml Graphviz
nextflow run ./NF-downstream_analysis/main.nf \
--input ./NF-downstream_analysis/samplesheet.csv \
--outdir ./output/NF-downstream_analysis_stacas \
--debug \
--integration STACAS \
-profile crick_eva \
-resume
