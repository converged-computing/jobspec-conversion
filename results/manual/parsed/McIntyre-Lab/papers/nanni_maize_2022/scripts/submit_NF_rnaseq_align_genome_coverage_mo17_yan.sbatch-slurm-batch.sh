#!/bin/bash
#FLUX: --job-name=nf
#FLUX: -t=18000
#FLUX: --urgency=16

export _JAVA_OPTIONS='-Djava.io.tmpdir=/blue/mcintyre/share/maize_ainsworth/ROZ_NF_mo17_yan'

date;hostname;pwd
NF=/blue/mcintyre/share/maize_ainsworth/scripts/rnaseq
REPORT=/blue/mcintyre/share/maize_ainsworth/mo17_align_nextflow_reports
    mkdir -p ${REPORT}
mkdir -p /blue/mcintyre/share/maize_ainsworth/ROZ_NF_mo17_yan
module load nextflow/20.07.1
export _JAVA_OPTIONS="-Djava.io.tmpdir=/blue/mcintyre/share/maize_ainsworth/ROZ_NF_mo17_yan"
nextflow run ${NF}/NF_rnaseq_align_genome_coverage_maize.nf \
    -c ${NF}/nextflow_run_rnaseq_align_genome_coverage_mo17_yan.config \
    -resume \
    -with-report ${REPORT}/align_genome_coverage_mo17_yan.html
