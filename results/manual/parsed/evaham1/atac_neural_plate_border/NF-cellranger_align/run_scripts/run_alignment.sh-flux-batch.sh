#!/bin/bash
#FLUX: --job-name=Integrated-npb/NF-cellranger_align
#FLUX: -t=259200
#FLUX: --urgency=16

export TERM='xterm'
export NXF_VER='21.10.6'
export NXF_SINGULARITY_CACHEDIR='/nemo/lab/briscoej/working/hamrude/NF_singularity'
export NXF_HOME='/nemo/lab/briscoej/working/hamrude/nextflow'
export NXF_WORK='work/'

ml purge
ml Nextflow/21.10.6
ml Singularity/3.6.4
ml Graphviz
export TERM=xterm
export NXF_VER=21.10.6
export NXF_SINGULARITY_CACHEDIR=/nemo/lab/briscoej/working/hamrude/NF_singularity
export NXF_HOME=/nemo/lab/briscoej/working/hamrude/nextflow
export NXF_WORK=work/
nextflow pull Streit-lab/cellranger_multiomic
nextflow run Streit-lab/cellranger_multiomic \
    -r main \
    -c ./conf/crick_params.config \
    --sample_sheet ./samplesheet.csv \
    --outdir ../output/NF-cellranger_align \
    --email eva.hamrud@crick.ac.uk \
    -resume
