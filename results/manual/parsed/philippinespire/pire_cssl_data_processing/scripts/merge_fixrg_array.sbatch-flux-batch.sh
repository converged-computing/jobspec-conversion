#!/bin/bash
#FLUX: --job-name=merge_fixrg
#FLUX: -c=40
#FLUX: --queue=main
#FLUX: --urgency=16

export SINGULARITY_BIND='/home/e1garcia'

enable_lmod
module load samtools
module load container_env/0.1
module load java
export SINGULARITY_BIND=/home/e1garcia
BAMDIR=$1
BAMPATTERN=*-merged-RG.bam
all_samples=$(ls $BAMDIR/$BAMPATTERN | sed -e 's/-merged-RG\.bam//' -e 's/.*\///g')
all_samples=($all_samples)
sample_name=${all_samples[${SLURM_ARRAY_TASK_ID}]}
echo ${sample_name}
cd ${BAMDIR}
crun java -jar /home/e1garcia/shotgun_PIRE/pire_cssl_data_processing/scripts/picard.jar AddOrReplaceReadGroups I=${sample_name}-merged-RG.bam O=${sample_name}-merged.rgfix-RG.bam RGID=${sample_name}-merged RGLB=mergedlibs RGPL=illumina RGPU=unit1 RGSM=${sample_name}-merged 
samtools index ${sample_name}-merged.rgfix-RG.bam
rm ${sample_name}-merged-RG.bam
rm ${sample_name}-merged-RG.bam.bai
