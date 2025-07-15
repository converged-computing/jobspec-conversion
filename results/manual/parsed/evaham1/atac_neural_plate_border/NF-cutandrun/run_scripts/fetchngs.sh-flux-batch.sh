#!/bin/bash
#FLUX: --job-name=NF-cutandrun_fetchngs
#FLUX: --urgency=16

export TERM='xterm'
export NXF_VER='22.10.3'
export NXF_SINGULARITY_CACHEDIR='/nemo/lab/briscoej/working/hamrude/NF_singularity'
export NXF_HOME='/flask/scratch/briscoej/hamrude/atac_neural_plate_border/NF-cutandrun'
export NXF_WORK='work/'

export TERM=xterm
ml purge
ml Java/11.0.2
ml Nextflow/22.10.3
ml Singularity/3.6.4
ml Graphviz
export NXF_VER=22.10.3
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/briscoej/working/hamrude/NF_singularity
export NXF_HOME=/flask/scratch/briscoej/hamrude/atac_neural_plate_border/NF-cutandrun
export NXF_WORK=work/
nextflow pull nf-core/fetchngs
nextflow run nf-core/fetchngs \
    -r 1.9 \
    -c ./conf/crick_params.config \
    --input ./data/SRR_Acc_List.txt \
    --outdir ../output/NF-cutandrun-H3k27ac_fetchngs \
    --email hamrude@crick.ac.uk \
    -resume
