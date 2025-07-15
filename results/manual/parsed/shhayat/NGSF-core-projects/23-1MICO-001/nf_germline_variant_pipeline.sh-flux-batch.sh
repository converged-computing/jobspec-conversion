#!/bin/bash
#FLUX: --job-name=germline
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

module --force purge
module load StdEnv/2020
module load nextflow/23.04.3
module load gentoo/2020
module load singularity/3.9.2
DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/23-1MICO-001/
dbSNP=/datastore/NGSF001/analysis/dbsnp/GCF_000001405.40.vcf
mkdir -p ${DIR}/analysis
nextflow run nf-core/sarek -profile singularity \
                           --input ${DIR}/sample_sheet.csv \
                           --genome GATK.GRCh38 \
                           --step mapping \
                           --save_mapped 'TRUE' \
                           --wes 'TRUE' \
                           --tools haplotypecaller,snpeff,vep \
                           --outdir ${DIR}/analysis
