#!/bin/bash
#FLUX: --job-name=rMATS
#FLUX: -c=10
#FLUX: -t=86400
#FLUX: --priority=16

module load star
rmat=/globalhome/hxo752/HPC/anaconda3/envs/rMATS/bin
index=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/22-1MILE-002/star-index
GTF=/datastore/NGSF001/analysis/references/rat/Rnor_6.0/ncbi-genomes-2020-10-30/GCF_000001895.5_Rnor_6.0/GCF_000001895.5_Rnor_6.0_genomic.gtf
DIR=/globalhome/hxo752/HPC/ngsf_git_repos/NGSF-core-projects/22-1MILE-001
NCPU=10
module load star/2.7.9a
mkdir -p ${DIR}/rmat_analysis_with_fastq/tmp
${rmat}/python ${rmat}/rmats.py --s1 $DIR/group1_fastq_files.txt \
                      --s2 $DIR/group2_fastq_files.txt \
                        --gtf ${GTF} \
                        --bi ${index} \
                        -t paired \
                        --readLength 141 \
                        --variable-read-length \ #used it for testing purposes
                        --nthread $NCPU \
                        --od ${DIR}/rmat_analysis_with_fastq \
                        --tmp ${DIR}/rmat_analysis_with_fastq/tmp \
                        --cstat 0.0005 #by default 0.0001 was used but I changed it to 0.0005 for the testing purposes
