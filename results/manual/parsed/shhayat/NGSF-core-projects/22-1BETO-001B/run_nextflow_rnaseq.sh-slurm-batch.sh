#!/bin/bash
#FLUX: --job-name=nf_rnaseq
#FLUX: -c=40
#FLUX: -t=144000
#FLUX: --urgency=16

module --force purge
module load StdEnv/2020
module load gentoo/2020
module load singularity/3.9.2
DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/22-1BETO-001B
DATA_DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/22-1BETO-001B/Fastq
mkdir -p  ${DIR}/analysis/results
mkdir -p  ${DIR}/analysis/work
nextflow run nf-core/rnaseq -profile singularity \
                             --input ${DIR}/design.csv \
                             --genome GRCh38 \
                             --save_reference TRUE \
                             -w ${DIR}/analysis/work \
                             --outdir ${DIR}/analysis/results
