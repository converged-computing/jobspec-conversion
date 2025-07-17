#!/bin/bash
#FLUX: --job-name=atac-NPB
#FLUX: -t=259200
#FLUX: --urgency=16

export TERM='xterm'
export NXF_VER='21.10.6'
export NXF_SINGULARITY_CACHEDIR='/nemo/lab/briscoej/working/hamrude/NF_singularity'
export NXF_HOME='/flask/scratch/briscoej/hamrude/atac_neural_plate_border/NF-hichip-downstream'
export NXF_WORK='work/'

export TERM=xterm
export NXF_VER=21.10.6
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/briscoej/working/hamrude/NF_singularity
export NXF_HOME=/flask/scratch/briscoej/hamrude/atac_neural_plate_border/NF-hichip-downstream
export NXF_WORK=work/
ml purge
ml Nextflow/21.10.6
ml Singularity/3.4.2
ml Graphviz
nextflow run ./main.nf \
--outdir ../output/NF-hichip-downstream \
-profile crick_full \
-resume
