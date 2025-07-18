#!/bin/bash
#FLUX: --job-name=gatk_merge_edit
#FLUX: -t=360000
#FLUX: --urgency=16

module purge
module load gatk/4.2.0.0
module load picard/2.23.8
module load bwa/intel/0.7.17
module load samtools/intel/1.14/
REF=/scratch/cb4097/Sequencing/Reference/*.fna
echo $REF
echo $1
gatk HaplotypeCaller -I $1 -R $REF -ploidy 1 -XL /scratch/cb4097/Sequencing/*/excludedregions_NC.bed -O ${1}_T.vcf
