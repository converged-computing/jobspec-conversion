#!/bin/bash
#FLUX: --job-name=nf
#FLUX: -c=40
#FLUX: -t=72000
#FLUX: --priority=16

module --force purge
module load StdEnv/2020
module load nextflow/22.04.3
module load gentoo/2020
module load singularity/3.9.2
OUTDIR="/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/DNAMethylation"
DATA="/datastore/NGSF001/datasets/bisulfite_seq/"
condition="Colon_Normal_Primary"
mkdir -p  ${OUTDIR}/analysis
mkdir -p  ${OUTDIR}/analysis/results
mkdir -p  ${OUTDIR}/analysis/work
nextflow run nf-core/methylseq -profile singularity \
                               --input ${DATA}/${condition}/'*_{1,2}.fastq.gz' \
                               -w ${OUTDIR}/analysis/work \
                               --outdir ${OUTDIR}/analysis/results \
                               --genome GRCh38 \
                               --single_end false
